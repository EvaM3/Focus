//
//  PersistenceManager.swift
//  Focus On
//
//  Created by Eva  Madarasz on 28/05/2023.
//

import Foundation
import CoreData

// MARK: - Core Data stack

class DataManager {
    
    
//    private var modelName: String?
//
//    init(modelName: String) {
//        self.modelName = modelName
//    }
    
 


//static let sharedManager = DataManager()
//
////2.
////private init() {} // Prevent clients from creating another instance.
//
//
//class func createGoal(createGoal: GoalEntity, context: NSManagedObjectContext) -> GoalEntity {
//     let newGoal = NSEntityDescription.insertNewObject(forEntityName: "GoalEntity", into: context) as? GoalEntity
//    return newGoal!
//}
//
//
//
//
//
//
//    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
//        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
//        // Create the coordinator and store
//        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedFocusObjectModel)
//
//
//        return coordinator
//    } ()
//
//    lazy var managedObjectContext: NSManagedObjectContext = {
//        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
//        let coordinator = self.persistentStoreCoordinator
//        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = coordinator
//        return managedObjectContext
//    }()
//
//
//
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "Focus_On")
//
//
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    private lazy var managedFocusObjectModel: NSManagedObjectModel = {
//        guard let focusURL = Bundle.main.url(forResource: "Focus_On", withExtension: "momd") else {
//            fatalError("Unable to Find Data Model")
//        }
//        guard let managedFocusObjectModel = NSManagedObjectModel(contentsOf: focusURL) else {
//            fatalError("Unable to Load Data Model")
//        }
//        return managedFocusObjectModel
//    } ()
//
//    func saveContext () {
//        let context  = DataManager.sharedManager.managedObjectContext
//        if let entityDescription = NSEntityDescription.entity(forEntityName: "GoalEntity", in: context) {
//            if NSManagedObject(entity: entityDescription, insertInto: context) != nil  {
//                guard context.hasChanges else { return }
//                           do {
//                               try context.save() // Crashes here once or twice a day :(
//                           }
//                           catch {
//                               print(error.localizedDescription)
//               }
//            }
//        }
//    }
//
}
    
    
//
//    func saveContext () {
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//                abort()
//            }
//        }
//    }

