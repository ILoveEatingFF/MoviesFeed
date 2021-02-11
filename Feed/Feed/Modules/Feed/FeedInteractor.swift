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
}

extension FeedInteractor: FeedInteractorInput {
	func reloadData() {

	}

	func loadNext() {

	}

}

private enum Constants {
	static let initialPage = 1
}