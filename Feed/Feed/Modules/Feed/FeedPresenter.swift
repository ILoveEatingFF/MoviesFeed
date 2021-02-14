//
//  FeedPresenter.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import Foundation
import CoreData

final class FeedPresenter {
	weak var view: FeedViewInput?
    weak var moduleOutput: FeedModuleOutput?
    
	private let router: FeedRouterInput
	private let interactor: FeedInteractorInput

    private var movies: [Movie] = []

    private var isNextPageLoading = false
    private var isReloading = false

    private let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.dateFormat = "yyyy-MM-dd"
        return result
    }()

    
    init(router: FeedRouterInput, interactor: FeedInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FeedPresenter: FeedModuleInput {
}

extension FeedPresenter: FeedViewOutput {

    func viewDidLoad() {
        isReloading = true
        interactor.reloadData()
    }

    func willDisplay(at index: Int) {
        guard !isReloading,
              !isNextPageLoading,
              movies.count - index < Constants.minMoviesDiffToLoadNext
                else { return }
        isNextPageLoading = true
        interactor.loadNext()
    }

    func didSelectCell(with viewModel: FeedCardViewModel) {
        router.showMovie(with: viewModel)
    }

    func gradeColor(grade: Double?) -> Color {
        guard let grade = grade else {return Color.red}
        switch grade {
        case 0...3.9:
            return Color.red
        case 4...6.9:
            return Color.yellow
        case 7...10:
            return Color.green
        default:
            return Color.red
        }
    }

}

extension FeedPresenter: FeedInteractorOutput {
    func didLoadCore(_ managedObject: [NSManagedObject]) {
        let viewModelsCore = makeViewModelsCore(with: managedObject)
        view?.updateView(with: viewModelsCore)
    }

    func didLoad(_ movies: [Movie], type: LoadingType) {
        switch type {
        case .reload:
            isReloading = false
            self.movies = movies
        case .nextPage:
            isNextPageLoading = false
            self.movies.append(contentsOf: movies)
        }
        let viewModels = makeViewModels(with: self.movies)
        view?.updateView(with: viewModels)
    }


}

private extension FeedPresenter {
    func makeViewModels(with movies: [Movie]) -> [FeedCardViewModel] {
        movies.map { movie in
            let posterPath = movie.posterPath ?? ""
            let imageUrl = ImagePath.smallImage(posterPath)
            return FeedCardViewModel(
                    id: movie.id ?? 0,
                    downloadDate: Date(),
                    title: movie.title ?? "",
                    image: nil,
                    urlToImage: imageUrl,
                    releaseDate: dateFormatter.string(from: movie.releaseDate ?? Date()),
                    voteAverage: String(movie.voteAverage ?? 0)
            )
        }
    }

    func makeViewModelsCore(with managedObj: [NSManagedObject]) -> [FeedCardViewModel] {
        managedObj.map { object in
            FeedCardViewModel(
                    id: object.value(forKey: "movieId") as? Int ?? 0,
                    downloadDate: object.value(forKey: "downloadDate") as? Date ?? Date(),
                    title: object.value(forKey: "title") as? String ?? "",
                    image: object.value(forKey: "image") as? Data,
                    urlToImage: "",
                    releaseDate: dateFormatter.string(from: object.value(forKey: "releaseDate") as? Date ?? Date()),
                    voteAverage: String(object.value(forKey: "voteAverage") as? Double ?? 0 )
            )
        }
    }
}
