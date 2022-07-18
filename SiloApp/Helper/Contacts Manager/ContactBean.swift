//
//  ContactBean.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import Foundation

public class ContactBean: NSObject
{
    var contactId: String?
    var firstName: String?
    var lastName: String?
    var countryCode: String?
    var mobileNumber: String?
    var email: String?
    var localContactId: String?
    
    init(contactId: String, firstName: String?, lastName: String?, countryCode: String?, mobileNumber: String?, email: String?)
    {
        self.contactId = contactId
        self.firstName = firstName
        self.lastName = lastName
        self.countryCode = countryCode
        self.mobileNumber = mobileNumber
        self.email = email
        self.localContactId = UUID().uuidString
    }
}
