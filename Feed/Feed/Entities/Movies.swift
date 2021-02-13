//
// Created by Иван Лизогуб on 11.02.2021.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let releaseDate: Date?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int?
}