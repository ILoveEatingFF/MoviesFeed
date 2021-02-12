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

	private let apiClient = ApiClient()
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
		apiClient.requestMovies(params: params) { [weak self] (result: Result<MoviesResponse, Error>) in
			guard let self = self else { return }
			switch result{
			case .success(let response):
				self.output?.didLoad(response.results, type: self.page == Constants.initialPage ? .reload: .nextPage)
				self.page = response.page + 1
			case .failure(let error):
				print(error)
			}
		}
	}

}
