//
//  MovieInfoInteractor.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import Foundation

final class MovieInfoInteractor {
	weak var output: MovieInfoInteractorOutput?

	private var movieId: Int

	private let dataManager: MovieInfoData = DataManager.shared

	init(movieId: Int) {
		self.movieId = movieId
	}
}

extension MovieInfoInteractor: MovieInfoInteractorInput {
	func load() {
		dataManager.requestMovie(with: movieId) { [unowned self] result in
			switch result {
			case .success(let data):
				output?.didLoad(with: data)
			case .failure(let error):
				print(error)
			}
		}
	}

}
