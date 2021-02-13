//
// Created by Иван Лизогуб on 13.02.2021.
//

import Foundation
import CoreData

final class DataManager {
    static let shared = DataManager()

    lazy var persistentContainer: NSPersistentContainer = PersistentContainer.shared.persistentContainer

    private lazy var taskContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
}

extension DataManager: FeedData {
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
            let matchingMovieRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieCore")
            let moviesIds = movies.map {$0.id}.compactMap {$0}
            matchingMovieRequest.predicate = NSPredicate(format: "movieId in %@", argumentArray: [moviesIds])

            let deleteRequest = NSBatchDeleteRequest(fetchRequest: matchingMovieRequest)
            deleteRequest.resultType = .resultTypeObjectIDs


//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieCore")
//            let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
//                let deleteRequest = try taskContext.execute(delete)

                let deleteResult = try taskContext.execute(deleteRequest) as? NSBatchDeleteResult

                if let deletedIds = deleteResult?.result as? [NSManagedObject] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedIds],
                            into: [persistentContainer.viewContext])
                }
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

                do {
                    try movieCore.update(with: movie)
                } catch {
                    taskContext.delete(movieCore)
                    print(error.localizedDescription)
                }
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

extension DataManager: MovieInfoData {
    func requestMovie(with movieId: Int, completion: @escaping (Result<MovieCore, Error>) -> Void) {
        let viewContext = persistentContainer.viewContext
        let fetchRequest = MovieCore.createFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "movieId = %@", NSNumber(value: movieId))


        do {
            let moviesCore = try viewContext.fetch(fetchRequest)
            assert(moviesCore.count < 2)

            if let movieCore = moviesCore.first as? MovieCore {
                completion(.success(movieCore))
            }
        } catch {
            print(error)
        }
    }
}