//
//  MovieCore+CoreDataProperties.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//
//

import Foundation
import CoreData


extension MovieCore {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MovieCore> {
        return NSFetchRequest<MovieCore>(entityName: "MovieCore")
    }

    @NSManaged public var downloadDate: Date
    @NSManaged public var image: Data
    @NSManaged public var overview: String
    @NSManaged public var releaseDate: Date
    @NSManaged public var title: String
    @NSManaged public var voteAverage: Double

}

extension MovieCore : Identifiable {

}
