//
// Created by Иван Лизогуб on 12.02.2021.
//

import Foundation

enum LoadingType {
    case reload
    case nextPage
}

enum ImagePath {
    static let imagePath = "https://image.tmdb.org/t/p/"
    static func smallImage(_ path: String) -> String {
        imagePath + ImageType.small.rawValue + path
    }
    static func originalImage(_ path: String) -> String {
        imagePath + ImageType.original.rawValue + path
    }
}

enum ImageType: String {
    case original
    case small = "w500"
}

enum Constants {
    static let initialPage = 1
    static let maxMoviesSaved = 60
    static let minMoviesDiffToLoadNext = 5
}

enum Color {
    case red
    case yellow
    case green
}