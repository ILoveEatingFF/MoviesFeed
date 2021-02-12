//
//  MovieInfoPresenter.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import Foundation

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
}

extension MovieInfoPresenter: MovieInfoInteractorOutput {
}
