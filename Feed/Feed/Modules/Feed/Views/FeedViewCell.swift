//
// Created by Иван Лизогуб on 11.02.2021.
//

import UIKit

protocol ReusableView {
    static var identifier: String { get }
}

class FeedViewCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let placeholder: UIImage? = UIImage(named: "default_poster")

    private let title = UILabel()

    private let bottomStack = UIStackView()
    private let releaseDate = UILabel()

    private let gradeStack = UIStackView()
    private let voteAverage = UILabel()
    private let maxGrade = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("FeedViewCell not implemented")
    }

    private func setup() {
        setupImageView()
        setupLabels()
    }

    private func setupConstraints() {
        [imageView,
         title,
         releaseDate,
         bottomStack].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),

            bottomStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            bottomStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5.0)
        ])
    }

    private func setupImageView() {
        contentView.addSubview(imageView)
    }

    private func setupLabels() {
        contentView.addSubview(title)
        contentView.addSubview(bottomStack)

        title.textColor = .white
        title.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 40)
        title.textAlignment = .center
        title.numberOfLines = 2

        bottomStack.axis = .horizontal
        bottomStack.distribution = .fill
        bottomStack.alignment = .fill

        bottomStack.addArrangedSubview(releaseDate)
        bottomStack.addArrangedSubview(gradeStack)

        releaseDate.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 34)
        releaseDate.textColor = .white
        setupGrade()
    }

    private func setupGrade() {
        bottomStack.addArrangedSubview(gradeStack)

        gradeStack.axis = .horizontal
        gradeStack.distribution = .fill
        gradeStack.alignment = .fill
        gradeStack.addArrangedSubview(voteAverage)
        gradeStack.addArrangedSubview(maxGrade)

        voteAverage.textAlignment = .right
        maxGrade.textAlignment = .left

        voteAverage.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 34)
        maxGrade.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 34)

        voteAverage.textColor = .white
        maxGrade.textColor = .white
        maxGrade.text = "/10"
    }

    func update(with viewModel: FeedCardViewModel, gradeColor: Color) {
        title.text = viewModel.title
        if let imageData = viewModel.image {
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.setImage(with: URL(string: viewModel.urlToImage), placeholder: placeholder)
        }
        voteAverage.text = viewModel.voteAverage
        releaseDate.text = viewModel.releaseDate

        switch gradeColor {
        case .red:
            voteAverage.textColor = .red
        case .yellow:
            voteAverage.textColor = .yellow
        case .green:
            voteAverage.textColor = .green
        }
    }
}

extension FeedViewCell: ReusableView {
    static var identifier: String {
        String(describing: self)
    }
}
