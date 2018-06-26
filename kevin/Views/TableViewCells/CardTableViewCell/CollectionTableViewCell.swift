//
//  CollectionTableViewCell.swift
//  kevin
//
//  Created by kevin.cheng on 6/23/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    var cellModels: [TitleCellModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var roundCardView: RoundView!
    
    var cellSize: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            collectionHeight.constant = cellSize.height
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.register(UINib(nibName: "BarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "verticalBarCell")
        collectionView.register(UINib(nibName: "ImageTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageTitleCell")
    }
    
}

extension CollectionTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.identifier, for: indexPath)
        if let barCell = cell as? BarCollectionViewCell {
            barCell.barTitleLabel.text = cellModel.title
            if let valueSubtitleModel = cellModel
                as? ValueSubtitleCellModel {
                barCell.barView.chartValue = Float(valueSubtitleModel.value)
            }
        } else if let imageTitleCell = cell as? ImageTitleCollectionViewCell,
            let imageTitleModel = cellModel as? ImageTitleCellModel {
            imageTitleCell.imageView.image = UIImage(named: imageTitleModel.imageName)
            imageTitleCell.titleLabel.text = imageTitleModel.title
        }
        return cell
    }
}

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}
