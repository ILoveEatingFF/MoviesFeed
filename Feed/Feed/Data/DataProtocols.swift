//
// Created by Иван Лизогуб on 13.02.2021.
//

import Foundation

protocol FeedData {
    func requestMoviesCore(completion: @escaping (Result<[MovieCore], Error>) -> Void)
    func syncMovies(with movies: [Movie])
}

protocol MovieInfoData {
    func requestMovie(with movieId: Int, completion: @escaping (Result<MovieCore, Error>) -> Void)
}