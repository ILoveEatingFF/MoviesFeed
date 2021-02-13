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
    private let viewModel: FeedCardViewModel

    private let imageView = UIImageView()

    init(output: MovieInfoViewOutput, viewModel: FeedCardViewModel) {
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
    }

    private func setupConstraints() {
        [imageView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)

        ])
    }

    private func setupImageView() {
        view.addSubview(imageView)

        imageView.setImage(with: URL(string: viewModel.urlToImage))
    }
}

extension MovieInfoViewController: MovieInfoViewInput {
    func updateView(with viewModel: MovieInfoViewModel) {
        imageView.image = UIImage(data: viewModel.image)
    }

}
