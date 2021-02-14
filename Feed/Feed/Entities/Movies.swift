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

extension Movie {
    private enum CodingKeys: String, CodingKey {
        case id, title, posterPath, releaseDate, overview, voteAverage, voteCount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
        overview = try? container.decode(String.self, forKey: .overview)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
    }
}