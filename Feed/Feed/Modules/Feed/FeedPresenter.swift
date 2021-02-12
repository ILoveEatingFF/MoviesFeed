//
//  FeedPresenter.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import Foundation

final class FeedPresenter {
	weak var view: FeedViewInput?
    weak var moduleOutput: FeedModuleOutput?
    
	private let router: FeedRouterInput
	private let interactor: FeedInteractorInput

    private var movies: [Movie] = []
    private let imagePath = "https://image.tmdb.org/t/p/"

    private var isNextPageLoading = false

    
    init(router: FeedRouterInput, interactor: FeedInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FeedPresenter: FeedModuleInput {
}

extension FeedPresenter: FeedViewOutput {

    func viewDidLoad() {
        interactor.reloadData()
    }

    func willDisplay(at index: Int) {
        guard !isNextPageLoading,
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
    func didLoad(_ movies: [Movie], type: LoadingType) {
        switch type {
        case .reload:
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
        movies.map{ movie in
            let posterPath = movie.posterPath ?? ""
            let imageUrl = imagePath + imageType.small.rawValue + posterPath
            return FeedCardViewModel(
                    title: movie.title ?? "",
                    urlToImage: imageUrl,
                    releaseDate: movie.releaseDate ?? "",
                    voteAverage: String(movie.voteAverage ?? 0),
                    overview: movie.overview ?? "")
        }
    }
}
