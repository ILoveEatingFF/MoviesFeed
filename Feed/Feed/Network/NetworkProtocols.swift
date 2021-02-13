//
// Created by Иван Лизогуб on 11.02.2021.
//

import Foundation

struct MoviesParams {
    let page: Int
}

enum InternalError: Error {
    case wrongURL
    case InternalServerError
}
