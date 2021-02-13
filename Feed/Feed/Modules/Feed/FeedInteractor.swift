//
//  FeedInteractor.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import Foundation

final class FeedInteractor {
	weak var output: FeedInteractorOutput?

	private var page = Constants.initialPage

	private let dataManager: FeedData = DataManager.shared

	private let apiClient = ApiClient()

	private var networkIsWorking = true

	private var numberOfElementsInCore = 0
}

extension FeedInteractor: FeedInteractorInput {
	func reloadData() {
		load()
	}

	func loadNext() {
		load()
	}

	private func load() {
		let params = MoviesParams(page: page)
		apiClient.requestMovies(params: params) { [unowned self] (result: Result<MoviesResponse, Error>) in
			switch result {
			case .success(let response):
				networkIsWorking = true
				if numberOfElementsInCore < Constants.maxMoviesSaved {
					dataManager.syncMovies(with: response.results)
				}
				output?.didLoad(response.results, type: page == Constants.initialPage ? .reload: .nextPage)
				page = response.page + 1
				numberOfElementsInCore += response.results.count
			case .failure(let error):
				print(error)
				guard networkIsWorking else { return }
				networkIsWorking = false
				dataManager.requestMoviesCore { result in
					switch result {
					case .success(let moviesCore):
						output?.didLoadCore(moviesCore)
					case .failure(let error):
						print(error)
					}
				}
			}
		}
	}

}
