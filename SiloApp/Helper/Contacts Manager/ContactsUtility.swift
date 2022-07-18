//
//  ContactsUtility.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Contacts
import ContactsUI
import CoreData

class ContactsUtility: NSObject {
    
    var arrContactsDicts = NSMutableArray()
    let contactStore = CNContactStore()
    private let entity = "Contact"
    private let service = WebServices()
    var isContactSyncInProgress = false
    
    static let sharedInstance: ContactsUtility = {
        let instance = ContactsUtility()
        return instance
    }()
    
    func requestedForAccess(complitionHandler:@escaping ( _ accessGranted:Bool)->Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        switch authorizationStatus {
        case .authorized:
            complitionHandler(true)
        case .notDetermined,.denied:
            self.contactStore.requestAccess(for: CNEntityType.contacts  ) { (access, accessError) in
                if access{
                    complitionHandler(access)
                }else{
                    if authorizationStatus == .denied{
                        ContactsUtility.sharedInstance.isContactSyncInProgress = false
                        let message="Allow access to contacts to this app using settings app"
                        debugPrint(message)
                    }
                }
            }
        default:
            complitionHandler(false)
        }
    }
    
    func getContact() -> [CNContact] {
        var results:[CNContact] = []
        let keyToContactFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey, CNContactIdentifierKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keyToContactFetch)
        fetchRequest.sortOrder = CNContactSortOrder.userDefault
        do {
            try self.contactStore.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) in
                debugPrint(contact.phoneNumbers.first?.value ?? "no")
                results.append(contact)
            })
        }
        catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        return results
    }
    
    func createDictOfContactList(compilationClosure: @escaping (_ arrContectDict:NSMutableArray)->()) {
        self.arrContactsDicts.removeAllObjects()
        DispatchQueue.global(qos: .background).async {
            self.requestedForAccess { (accessGranted) in
                if(accessGranted) {
                    for contact in self.getContact() {
                        for tempContact:CNLabeledValue in contact.phoneNumbers {
                            if contact.givenName.lowercased() == "spam" || contact.givenName.lowercased() == "identified as spam" {
                                continue
                            }
                            var emailAddress: String?
                            if let email = contact.emailAddresses.first?.value {
                                emailAddress = email as String
                            }
                            var countryCode: String?
                            if let code = tempContact.value.value(forKey: "countryCode") as? String {
                                countryCode = code.uppercased().getPhoneCode
                            } else {
                                countryCode = Defaults.loggedInUser?.countryCode
                            }
                            let finalNumber = tempContact.value.stringValue
                            if (finalNumber != "") {
                                let dict = ContactBean(contactId: contact.identifier, firstName: contact.givenName, lastName: contact.familyName, countryCode: countryCode, mobileNumber: finalNumber, email: emailAddress)
                                self.arrContactsDicts.add(dict)
                            }
                        }
                    }
                    compilationClosure(self.arrContactsDicts)
                } else {
                    compilationClosure([])
                }
            }
        }
    }
    
    func saveNewContactInDb(dict:NSMutableArray, completionHandler:@escaping (_ success:Bool) -> ()) -> Void {
        DispatchQueue.global(qos: .background).async {
            for newContact in dict {
                guard let tempContact = newContact as? ContactBean else { return }
                let objContact = (ContactsCoreDataManager.sharedInstance.createObjectForEntity(entityName: self.entity, taskContext: ContactsCoreDataManager.sharedInstance.bGManagedObjectContext) ) as! Contact
                objContact.localContactId = tempContact.localContactId
                objContact.contactId = tempContact.contactId
                objContact.firstName = tempContact.firstName
                objContact.lastName = tempContact.lastName
                objContact.email = tempContact.email
                objContact.countryCode = tempContact.countryCode
                objContact.mobileNumber = tempContact.mobileNumber
                ContactsCoreDataManager.sharedInstance.saveContextInBG()
            }
            completionHandler(true)
        }
    }
    
    func deleteAllContactFromDb(completionHandler: @escaping () -> ()) -> Void {
        DispatchQueue.global(qos: .background).async {
            let contacts = self.getAllContactsFromDB()
            for contact in contacts {
                ContactsCoreDataManager.sharedInstance.deleteObject(object: contact, taskContext: ContactsCoreDataManager.sharedInstance.bGManagedObjectContext)
            }
            completionHandler()
        }
    }
    
    func syncPhoneBookContactsWithLocalDB(completionHandler:@escaping (_ success:Bool) -> ()) {
        if(ContactsUtility.sharedInstance.isContactSyncInProgress == false) {
            ContactsUtility.sharedInstance.isContactSyncInProgress = true
            self.createDictOfContactList { (arrDictContactList) in
                DispatchQueue.global(qos: .background).async {
                    if let arrContactList =  ContactsCoreDataManager.sharedInstance.getObjectsforEntity(strEntity: self.entity, ShortBy: "", isAscending: false, predicate: nil, groupBy: "", taskContext: ContactsCoreDataManager.sharedInstance.bGManagedObjectContext) as? NSArray, arrContactList.count > 0 {
                        //Check for require update contact in db
                        let tempArrContactDict = self.requireUpdateContacts(dbContacts: arrContactList as! [Contact])
                        if tempArrContactDict.count > 0 {
                            //After sync new contact list with local db there is still contact is avalilabe in contact dict so it means there is newly insertad contact so insert new contact in the local data base
                            debugPrint("This is the new contact added in DB --> \(String(describing: tempArrContactDict))")
                            self.uploadContacts(dataArrar: tempArrContactDict) {
                                self.saveNewContactInDb(dict:tempArrContactDict,completionHandler: { (success) in
                                    completionHandler(true)
                                })
                            }
                        } else {
                            debugPrint("There is no new contact(s) added")
                            completionHandler(true)
                        }
                    } else {
                        //Save all new contact in db
                        if self.arrContactsDicts.count > 0 {
                            debugPrint("Fresh contact list added")
                            self.uploadContacts(dataArrar: self.arrContactsDicts) {
                                self.saveNewContactInDb(dict: self.arrContactsDicts, completionHandler: { (success) in
                                    completionHandler(true)
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func requireUpdateContacts(dbContacts: [Contact]) -> NSMutableArray {
        let tempArrContactDict = self.arrContactsDicts
        for contact in dbContacts {
            let tempContactDb = contact
            let mobileNumber = tempContactDb.mobileNumber
            if(mobileNumber != "") {
                let arrFilterContact = self.arrContactsDicts.filter({($0 as! ContactBean).mobileNumber! == mobileNumber!})
                if arrFilterContact.count > 0 {
                    let filterdContact = arrFilterContact.first as! ContactBean
                    if(filterdContact.firstName != tempContactDb.firstName || filterdContact.lastName != tempContactDb.lastName || filterdContact.email != tempContactDb.email) {
                        tempContactDb.firstName = filterdContact.firstName
                        tempContactDb.lastName = filterdContact.lastName
                        tempContactDb.email = filterdContact.email
                        tempContactDb.countryCode = filterdContact.countryCode
                        tempContactDb.contactId = filterdContact.contactId
                        debugPrint("This contact is edited in DB --> \(String(describing: tempContactDb.mobileNumber))")
                        ContactsCoreDataManager.sharedInstance.saveContextInBG()
                    }
                    tempArrContactDict.remove(arrFilterContact.first as Any)
                } else {
                    //This contact is not available in newContact dict so it means this contact is deleted in contact directory so we need to delete from out data base.
                    debugPrint("This contact is deleted from DB --> \(String(describing: tempContactDb.mobileNumber))")
                    self.deleteContacts(id: tempContactDb.localContactId ?? "") {
                        ContactsCoreDataManager.sharedInstance.deleteObject(object: tempContactDb, taskContext: ContactsCoreDataManager.sharedInstance.bGManagedObjectContext)
                    }
                }
            }
        }
        return tempArrContactDict
    }
    
    func getAllContactsFromDB() -> [Contact] {
        if let arrContactList =  ContactsCoreDataManager.sharedInstance.getObjectsforEntity(strEntity: self.entity, ShortBy: "", isAscending: false, predicate: nil, groupBy: "", taskContext: ContactsCoreDataManager.sharedInstance.bGManagedObjectContext) as? [Contact], arrContactList.count > 0 {
            return arrContactList
        }
        return []
    }
    
    func uploadContacts(dataArrar: NSMutableArray, success: @escaping (() -> ())) {
        var contacts: JSONDictionaryArray = []
        for newContact in dataArrar {
            guard let tempContact = newContact as? ContactBean else { return }
            var dict: JSONDictionary = [:]
            dict[ApiKey.contactId] = tempContact.localContactId
            if let firstName = tempContact.firstName, !firstName.isEmpty,
               let lastName = tempContact.lastName, !lastName.isEmpty {
                dict[ApiKey.contactName] = "\(firstName) \(lastName)"
            } else if let firstName = tempContact.firstName, !firstName.isEmpty {
                dict[ApiKey.contactName] = firstName
            } else if let lastName = tempContact.lastName, !lastName.isEmpty {
                dict[ApiKey.contactName] = lastName
            } else {
                dict[ApiKey.contactName] = tempContact.mobileNumber ?? ""
            }
            if let number = tempContact.mobileNumber, let cCode = tempContact.countryCode, number.contains(s: cCode) {
                dict[ApiKey.phoneNo] = number.replacingOccurrences(of: cCode, with: "").removePhoneNumberMask
                dict[ApiKey.fullPhoneNo] = tempContact.mobileNumber?.removePhoneNumberMask
            } else {
                dict[ApiKey.phoneNo] = tempContact.mobileNumber?.removePhoneNumberMask
                dict[ApiKey.fullPhoneNo] = (tempContact.countryCode ?? "") + (tempContact.mobileNumber?.removePhoneNumberMask ?? "")
            }
            dict[ApiKey.countryCode] = tempContact.countryCode
            contacts.append(dict)
        }
        service.contactSyncWithServer(params: [ApiKey.contacts: contacts]) { (model: CommonResponseData?) in
            debugPrint(model as Any)
            success()
        } failure: { (error, errorData) in
            debugPrint(error)
        }
    }
    
    func deleteContacts(id: String, success: @escaping (() -> ())) {
        var dict: JSONDictionary = [:]
        dict[ApiKey.contactId] = id
        service.deleteContactFromServer(params: [ApiKey.contacts: [dict]]) { (model: CommonResponseData?) in
            debugPrint(model as Any)
            success()
        } failure: { (error, errorData) in
            debugPrint(error)
        }
    }
}

extension String {
    
    var getPhoneCode: String {
        if let path = Bundle.main.path(forResource: "dialCode", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let prefixCodes = jsonResult as? [String: String] {
                    let countryDialingCode = prefixCodes[self] ?? "1"
                    debugPrint(countryDialingCode)
                    return "+" + countryDialingCode
                }
            } catch {
                debugPrint(error)
            }
        }
        return "+1"
    }
}
