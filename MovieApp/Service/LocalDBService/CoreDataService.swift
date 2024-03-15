//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Winter on 3/15/24.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func nowPlayingMovie(_ id: Int64,_ title: String,_ posterPath: String?) {
        let movie = NowPlayingMovieTable(context: persistentContainer.viewContext)
        movie.id = id
        movie.title = title
        movie.posterPath = posterPath
    }
    
    func popularMovie(_ id: Int64,_ title: String,_ posterPath: String?) {
        let movie = PopularMovieTable(context: persistentContainer.viewContext)
        movie.id = id
        movie.title = title
        movie.posterPath = posterPath
    }
    
    func topRatedMovie(_ id: Int64,_ title: String,_ posterPath: String?) {
        let movie = TopRatedMovieTable(context: persistentContainer.viewContext)
        movie.id = id
        movie.title = title
        movie.posterPath = posterPath
    }
    
    func upcomingMovie(_ id: Int64,_ title: String,_ posterPath: String?) {
        let movie = UpcomingMovieTable(context: persistentContainer.viewContext)
        movie.id = id
        movie.title = title
        movie.posterPath = posterPath
    }
    
    func fetchNowPlayingMovie() -> [NowPlayingMovieTable] {
        let request: NSFetchRequest<NowPlayingMovieTable> = NowPlayingMovieTable.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    func deletAllNowPlayingData() {
        let request = fetchNowPlayingMovie()
        
        do {
            request.forEach { movie in
                persistentContainer.viewContext.delete(movie)
            }
            try persistentContainer.viewContext.save()
            
        } catch {
            print(error)
        }
    }
    
    func fetchPopularMovie() -> [PopularMovieTable] {
        let request: NSFetchRequest<PopularMovieTable> = PopularMovieTable.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    func deletAllPopulaData() {
        let request = fetchPopularMovie()
        
        do {
            request.forEach { movie in
                persistentContainer.viewContext.delete(movie)
            }
            try persistentContainer.viewContext.save()
            
        } catch {
            print(error)
        }
    }
    
    func fetchTopRatedMovie() -> [TopRatedMovieTable] {
        let request: NSFetchRequest<TopRatedMovieTable> = TopRatedMovieTable.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    func deletAllTopRatedData() {
        let request = fetchTopRatedMovie()
        
        do {
            request.forEach { movie in
                persistentContainer.viewContext.delete(movie)
            }
            try persistentContainer.viewContext.save()
            
        } catch {
            print(error)
        }
    }
    
    func fetchUpcomingMovie() -> [UpcomingMovieTable] {
        let request: NSFetchRequest<UpcomingMovieTable> = UpcomingMovieTable.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    func deletAllUpcomingData() {
        let request = fetchUpcomingMovie()
        
        do {
            request.forEach { movie in
                persistentContainer.viewContext.delete(movie)
            }
            try persistentContainer.viewContext.save()
            
        } catch {
            print(error)
        }
    }
    
    
    
}
