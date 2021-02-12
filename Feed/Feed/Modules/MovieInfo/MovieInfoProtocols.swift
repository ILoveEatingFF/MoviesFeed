//
//  MovieInfoProtocols.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import Foundation

protocol MovieInfoModuleInput {
	var moduleOutput: MovieInfoModuleOutput? { get }
}

protocol MovieInfoModuleOutput: class {
}

protocol MovieInfoViewInput: class {
}

protocol MovieInfoViewOutput: class {
}

protocol MovieInfoInteractorInput: class {
}

protocol MovieInfoInteractorOutput: class {
}

protocol MovieInfoRouterInput: class {
}
