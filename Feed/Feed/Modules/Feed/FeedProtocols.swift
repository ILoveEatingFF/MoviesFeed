//
//  FeedProtocols.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import Foundation

protocol FeedModuleInput {
	var moduleOutput: FeedModuleOutput? { get }
}

protocol FeedModuleOutput: class {
}

protocol FeedViewInput: class {
}

protocol FeedViewOutput: class {
	func viewDidLoad()
}

protocol FeedInteractorInput: class {
	func reloadData()
	func loadNext()
}

protocol FeedInteractorOutput: class {
}

protocol FeedRouterInput: class {
}
