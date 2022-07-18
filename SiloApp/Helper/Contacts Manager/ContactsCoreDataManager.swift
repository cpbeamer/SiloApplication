//
//  ContactsCoreDataManager.swift
//  SiloApp
//
//  Created by Cary Beam on 7/18/22.
//

import UIKit
import Foundation
import CoreData

class ContactsCoreDataManager {
    
    static let DBName = "Switch"
    static let sharedInstance = ContactsCoreDataManager()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: ContactsCoreDataManager.DBName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext: NSManagedObjectContext?
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext?.parent = self.bGManagedObjectContext
        managedObjectContext?.automaticallyMergesChangesFromParent = true
        return managedObjectContext!
    }()
    
    lazy var bGManagedObjectContext: NSManagedObjectContext = {
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        return taskContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: ContactsCoreDataManager.DBName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError?
            {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("\(ContactsCoreDataManager.DBName).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            // Configure automatic migration.
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }()
    
    func saveContext() {
        managedObjectContext.perform {
            do {
                if self.managedObjectContext.hasChanges
                {
                    try self.managedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                debugPrint("Unable to Save Changes of Managed Object Context")
                debugPrint("\(saveError), \(saveError.localizedDescription)")
            }
        }
    }
    
    func saveContextInBG()
    {
        do {
            if self.bGManagedObjectContext.hasChanges {
                try self.bGManagedObjectContext.save()
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func createObjectForEntity(entityName:String,taskContext: NSManagedObjectContext) -> AnyObject? {
        if (entityName != "") {
            let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: taskContext)
            let createdObject = NSManagedObject(entity: entityDescription!, insertInto: taskContext)
            return createdObject as AnyObject
        }
        return nil
    }
    
    func getObjectsforEntity(strEntity : String, ShortBy : String, isAscending : Bool, predicate : NSPredicate!, groupBy : NSString, taskContext : NSManagedObjectContext) -> AnyObject {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: strEntity)
        fetchRequest.returnsObjectsAsFaults = false
        if predicate != nil {
            fetchRequest.predicate = predicate
        }
        if ShortBy != "" {
            let sortDescriptor1 = NSSortDescriptor(key: ShortBy, ascending: isAscending)
            fetchRequest.sortDescriptors = [sortDescriptor1]
        }
        if groupBy != "" {
            fetchRequest.propertiesToGroupBy = [groupBy]
        }
        do {
            let result = try taskContext.fetch(fetchRequest)
            return result as AnyObject
        } catch {
            let fetchError = error as NSError
            debugPrint(fetchError)
            return nil as [AnyObject]? as AnyObject
        }
    }
    
    func deleteObject(object : NSManagedObject,taskContext: NSManagedObjectContext) {
        taskContext.delete(object)
        if(taskContext == self.bGManagedObjectContext) {
            self.saveContextInBG()
        } else {
            self.saveContext()
        }
    }
    
}
