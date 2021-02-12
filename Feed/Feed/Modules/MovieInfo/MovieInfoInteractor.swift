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
}

extension MovieInfoInteractor: MovieInfoInteractorInput {
}
