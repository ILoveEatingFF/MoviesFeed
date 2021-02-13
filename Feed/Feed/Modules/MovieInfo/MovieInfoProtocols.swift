//
//  MovieInfoProtocols.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import Foundation
import CoreData

protocol MovieInfoModuleInput {
	var moduleOutput: MovieInfoModuleOutput? { get }
}

protocol MovieInfoModuleOutput: class {
}

protocol MovieInfoViewInput: class {
	func updateView(with viewModel: MovieInfoViewModel)
}

protocol MovieInfoViewOutput: class {
	func viewDidLoad()
}

protocol MovieInfoInteractorInput: class {
	func load()
}

protocol MovieInfoInteractorOutput: class {
	func didLoad(with managedObject: NSManagedObject)
}

protocol MovieInfoRouterInput: class {
}
