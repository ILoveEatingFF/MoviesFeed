//
//  MovieInfoContainer.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import UIKit

final class MovieInfoContainer {
    let input: MovieInfoModuleInput
	let viewController: UIViewController
	private(set) weak var router: MovieInfoRouterInput!

	static func assemble(with context: MovieInfoContext) -> MovieInfoContainer {
        let router = MovieInfoRouter()
        let interactor = MovieInfoInteractor(movieId: context.id)
        let presenter = MovieInfoPresenter(router: router, interactor: interactor)
		let viewController = MovieInfoViewController(output: presenter, viewModel: context.viewModel)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return MovieInfoContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MovieInfoModuleInput, router: MovieInfoRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MovieInfoContext {
	weak var moduleOutput: MovieInfoModuleOutput?
	var viewModel: FeedCardViewModel?
	var id: Int
}
