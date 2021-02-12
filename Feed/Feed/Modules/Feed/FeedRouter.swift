//
//  FeedRouter.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import UIKit

final class FeedRouter {
    private var navigationController: UINavigationController? {
        navigationControllerProvider?()
    }

    var navigationControllerProvider: (() -> UINavigationController?)?
}

extension FeedRouter: FeedRouterInput {
    func showMovie(with viewModel: FeedCardViewModel) {
        let context = MovieInfoContext(moduleOutput: nil, viewModel: viewModel)
        let container = MovieInfoContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }

}
