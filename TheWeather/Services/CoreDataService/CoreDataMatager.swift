//
//  CoreDataMatager.swift
//  TheWeather
//
//  Created by Иван Луганцов on 26.05.2023.
//

import Foundation
import CoreData

class StorageManager {

    static let shared = StorageManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TheWeather")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unreserved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var viewContext: NSManagedObjectContext

    private init() {
        viewContext = persistentContainer.viewContext
    }

    public func fetchData<T: NSManagedObject>(completion: (Result<[T], Error>) -> Void) {

        let fetchRequest: NSFetchRequest<T> = T().fetchRequest()
        do {
            let data = try viewContext.fetch(fetchRequest)
            completion(.success(data))
        } catch let error {
            completion(.failure(error))
        }
    }

    public func save<T: NSManagedObject>(model: T) {
        saveContext()
    }

    public func edit<T: NSManagedObject>(model: T) {
        saveContext()
    }

    public func delete<T: NSManagedObject>(data: T) {
        viewContext.delete(data)
        saveContext()
    }

    public func clearCoreData() {
        let entities = self.persistentContainer.managedObjectModel.entities
        entities
            .compactMap({ $0.name })
            .forEach(clearDeepObjectEntity)
    }

    private func clearDeepObjectEntity(_ entity: String) {
        let context = viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print("There was an error")
        }
    }

    // MARK: - Core Data Saving Support
    private func saveContext() {
        guard viewContext.hasChanges else { return }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unreserved error \(nsError), \(nsError.userInfo)")
            }
    }
}

extension NSManagedObject {

    func fetchRequest<T>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: String(describing: T.self))
    }
}
