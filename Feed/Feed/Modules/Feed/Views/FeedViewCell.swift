//
// Created by Иван Лизогуб on 11.02.2021.
//

import UIKit

protocol ReusableView {
    static var identifier: String { get }
}

class FeedViewCell: UICollectionViewCell {

    private let imageView = UIImageView()

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
    }

    private func setupConstraints() {
        [imageView
         ].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupImageView() {
        contentView.addSubview(imageView)
    }

    func update(with viewModel: FeedCardViewModel) {
        imageView.setImage(with: URL(string: viewModel.urlToImage))
    }
}

extension FeedViewCell: ReusableView {
    static var identifier: String {
        String(describing: self)
    }
}
