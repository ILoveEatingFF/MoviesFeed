//
//  MovieCore+CoreDataClass.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//
//

import Foundation
import CoreData

@objc(MovieCore)
public class MovieCore: NSManagedObject {
    //TODO: fix bug update when user got info from db and cant get images
    func update(with movie: Movie) throws {
        guard let posterPath = movie.posterPath,
              let url = URL(string: ImagePath.smallImage(posterPath)),
              let imageData = try? Data(contentsOf: url),
              let release = movie.releaseDate,
              let movieId = movie.id
                else { throw InternalError.failedToUpdateCoreData }

        self.movieId = NSNumber(value: movieId)
        image = imageData
        downloadDate = Date()
        overview = movie.overview ?? ""
        title = movie.title ?? ""
        voteAverage = movie.voteAverage ?? 0.0
        releaseDate = release

    }
}
