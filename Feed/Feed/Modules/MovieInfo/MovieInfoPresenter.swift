//
//  MovieInfoPresenter.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import Foundation
import CoreData

final class MovieInfoPresenter {
	weak var view: MovieInfoViewInput?
    weak var moduleOutput: MovieInfoModuleOutput?
    
	private let router: MovieInfoRouterInput
	private let interactor: MovieInfoInteractorInput
    
    init(router: MovieInfoRouterInput, interactor: MovieInfoInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MovieInfoPresenter: MovieInfoModuleInput {
}

extension MovieInfoPresenter: MovieInfoViewOutput {
    func viewDidLoad() {
        interactor.load()
    }

}

extension MovieInfoPresenter: MovieInfoInteractorOutput {
    func didLoad(with managedObject: NSManagedObject) {
        let viewModel = makeViewModel(with: managedObject)
        view?.updateView(with: viewModel)
    }

}

private extension MovieInfoPresenter {
    func makeViewModel(with managedObject: NSManagedObject) -> MovieInfoViewModel {
        MovieInfoViewModel(
                downloadMovieDate: managedObject.value(forKey: "downloadDate") as? Date ?? Date(),
                image: managedObject.value(forKey: "image") as! Data,
                overview: managedObject.value(forKey: "overview") as? String ?? ""
        )
    }
}