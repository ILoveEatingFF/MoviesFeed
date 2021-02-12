//
// Created by Иван Лизогуб on 12.02.2021.
//

import Foundation

enum LoadingType {
    case reload
    case nextPage
}

enum imageType: String {
    case original
    case small = "w500"
}

enum Constants {
    static let initialPage = 1
    static let maxMoviesForCore = 60
    static let minMoviesDiffToLoadNext = 5
}

enum Color {
    case red
    case yellow
    case green
}