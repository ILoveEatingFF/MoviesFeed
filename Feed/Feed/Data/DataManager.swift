//
// Created by Иван Лизогуб on 13.02.2021.
//

import Foundation
import CoreData

final class DataManager {
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Feed")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()

    private lazy var taskContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()

    func requestMoviesCore(completion: @escaping (Result<[MovieCore], Error>) -> Void) {
        let viewContext = persistentContainer.viewContext
        let fetchRequest = MovieCore.createFetchRequest()
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let moviesCore = try viewContext.fetch(fetchRequest)
            completion(.success(moviesCore))
        } catch {
            print("Error: \(error) failed to fetch from CoreData")
            completion(.failure(error))
        }
    }

    func syncMovies(with movies: [Movie]) {
        taskContext.perform { [unowned self] in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieCore")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try taskContext.execute(deleteRequest)
            } catch {
                print("Error: \(error) syncMovies deleteResult")
                return
            }

            for movie in movies {
                guard let movieCore = NSEntityDescription.insertNewObject(
                        forEntityName: "MovieCore", into: taskContext) as? MovieCore
                        else {
                    print("Error: failed to create MovieCore")
                    return
                }

                movieCore.update(with: movie)
            }

            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                taskContext.reset()
            }
        }
    }


}