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
        /* Передаю в следующий модуль viewModel, так как не понятно, как отоброжать дату загрузки,
         если сохраняются не все картинки(дату получения с сервера?), если этот функционал не нужен, то передайте nil
          во viewModel.
         */
        let context = MovieInfoContext(moduleOutput: nil, viewModel: viewModel, id: viewModel.id)
        let container = MovieInfoContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }

}
