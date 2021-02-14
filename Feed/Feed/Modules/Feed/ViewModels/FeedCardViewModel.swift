//
// Created by Иван Лизогуб on 11.02.2021.
//

import Foundation

struct FeedCardViewModel {
    let id: Int
    let downloadDate: Date
    let title: String
    let image: Data?
    let urlToImage: String
    let releaseDate: String
    let voteAverage: String
}
