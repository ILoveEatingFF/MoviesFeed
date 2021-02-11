//
//  FeedViewController.swift
//  Feed
//
//  Created by Иван Лизогуб on 11.02.2021.
//  
//

import UIKit

final class FeedViewController: UIViewController {
	private let output: FeedViewOutput

    private let collectionViewLayout =  UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

    private var viewModels: [FeedCardViewModel] = []

    private let backgroundColor = UIColor.white

    init(output: FeedViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = backgroundColor
        self.view = view
    }
	override func viewDidLoad() {
		super.viewDidLoad()

	}

    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: FeedViewCell.identifier)
        collectionView.backgroundColor = backgroundColor
    }
}

extension FeedViewController: FeedViewInput {
}

extension FeedViewController: UICollectionViewDelegate {

}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedViewCell.identifier, for: indexPath)
                as? FeedViewCell else { fatalError("can't dequeue FeedViewCell")}
        cell.update(with: viewModels[indexPath.item])
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = 1.2
        let width = collectionView.frame.width
        let height = width * ratio
        return CGSize(width: width, height: height)
    }
}