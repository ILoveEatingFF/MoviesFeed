//
//  MovieInfoViewController.swift
//  Feed
//
//  Created by Иван Лизогуб on 12.02.2021.
//  
//

import UIKit

final class MovieInfoViewController: UIViewController {
	private let output: MovieInfoViewOutput

    private let viewModel: FeedCardViewModel?

    private let imageView = UIImageView()

    private let downloadDate = UILabel()

    private let overview = UILabel()

    private let formatter: DateFormatter = {
        let result = DateFormatter()
        result.calendar = Calendar(identifier: .iso8601)
        result.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return result
    }()

    init(output: MovieInfoViewOutput, viewModel: FeedCardViewModel?) {
        self.output = output
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        setup()
        setupConstraints()
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        output.viewDidLoad()
	}

    private func setup() {
        setupImageView()
        setupDownloadDate()
        setupOverview()
    }

    private func setupConstraints() {
        [imageView,
        downloadDate,
        overview].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            downloadDate.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            downloadDate.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            downloadDate.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),

            overview.topAnchor.constraint(equalTo: downloadDate.bottomAnchor, constant: 20.0),
            overview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10.0),
            overview.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            overview.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -16.0)
        ])
    }

    private func setupImageView() {
        view.addSubview(imageView)

        if let viewModel = viewModel {
            imageView.setImage(with: URL(string: viewModel.urlToImage))
        }
    }

    private func setupDownloadDate() {
        view.addSubview(downloadDate)

        downloadDate.textColor = .white
        downloadDate.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 40.0)
        downloadDate.textAlignment = .center

        if let viewModel = viewModel {
            downloadDate.text = formatter.string(from: viewModel.downloadDate)
        }
    }

    private func setupOverview() {
        view.addSubview(overview)

        overview.textColor = .lightGray
        overview.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
        overview.text = ""
        overview.numberOfLines = 0
    }
}

extension MovieInfoViewController: MovieInfoViewInput {
    func updateView(with viewModelCore: MovieInfoViewModel) {
        imageView.image = UIImage(data: viewModelCore.image)
        downloadDate.text = formatter.string(from: viewModelCore.downloadMovieDate)
        overview.text = viewModelCore.overview
    }

}
