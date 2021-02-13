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

	private let dataManager = DataManager()

	private let apiClient = ApiClient()

	private var networkIsWorking = true
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
				dataManager.syncMovies(with: response.results)
				output?.didLoad(response.results, type: page == Constants.initialPage ? .reload: .nextPage)
				page = response.page + 1
			case .failure(let error):
//				guard networkIsWorking else { break }
				networkIsWorking = false
				dataManager.requestMoviesCore { result in
					switch result {
					case .success(let moviesCore):
						let movies = makeMovies(from: moviesCore)
						for data in moviesCore {
							print(data.value(forKey: "title"))
						}
						output?.didLoad(movies, type: .reload)
					case .failure(let error):
						print(error)
					}
				}
			}
		}
	}

	private func makeMovies(from moviesCore: [MovieCore]) -> [Movie] {

		moviesCore.map { movieCore in
			Movie(
					title: movieCore.value(forKey: "title") as? String,
					posterPath: movieCore.value(forKey: "posterPath") as? String,
					releaseDate: movieCore.value(forKey: "releaseDate") as? Date,
					overview: movieCore.value(forKey: "overview") as? String,
					voteAverage: movieCore.value(forKey: "voteAverage") as? Double,
					voteCount: movieCore.value(forKey: "voteCount") as? Int
			)
		}
	}
}
