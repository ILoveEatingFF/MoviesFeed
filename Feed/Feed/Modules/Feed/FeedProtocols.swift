//
//  FeedProtocols.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import Foundation
import CoreData

protocol FeedModuleInput {
	var moduleOutput: FeedModuleOutput? { get }
}

protocol FeedModuleOutput: class {
}

protocol FeedViewInput: class {
	func updateView(with viewModels: [FeedCardViewModel])
}

protocol FeedViewOutput: class {
	func viewDidLoad()
	func gradeColor(grade: Double?) -> Color
	func didSelectCell(with viewModel: FeedCardViewModel)
	func willDisplay(at index: Int)
}

protocol FeedInteractorInput: class {
	func reloadData()
	func loadNext()
}

protocol FeedInteractorOutput: class {
	func didLoad(_ movies: [Movie], type: LoadingType)
	func didLoadCore(_ managedObject: [NSManagedObject])
}

protocol FeedRouterInput: class {
	func showMovie(with viewModel: FeedCardViewModel)
}
