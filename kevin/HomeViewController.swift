//
//  ViewController.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    let cellModels: [[CellModel]] = [[SubtitleCellModel(identifier: "gradientCell", title: "Hello from Kevin",
                                                   subtitle: "Today is another nice day!!")],
                [SubtitleCellModel(identifier: "subtitleCell", title: "You have ran", subtitle: "100 miles"),
                   SubtitleCellModel(identifier: "subtitleCell", title: "You have consumed", subtitle: "100 calories")],
                [SubtitleCellModel(identifier: "cardCell", title: "You are all kinds of awesome!", subtitle: "No kidding!")],
                [CollectionCellModel(identifier: "collectionCell", cellSize: CGSize(width: 60, height: 150),
                                     collectionCellModels: [ValueSubtitleCellModel(identifier: "verticalBarCell",
                                                                                   title: "Cholote", subtitle: "", value: 0.1),
                                                            ValueSubtitleCellModel(identifier: "verticalBarCell",
                                                                                   title: "Peanut", subtitle: "", value: 0.5),
                                                            ValueSubtitleCellModel(identifier: "verticalBarCell",
                                                                                   title: "Candy", subtitle: "", value: 0.35)])],
                [CollectionCellModel(identifier: "collectionCell", cellSize: CGSize(width: 177, height: 100),
                                     collectionCellModels: [ImageTitleCellModel(identifier: "imageTitleCell",
                                                                                   title: "Filter 1", imageName: ""),
                                                            ImageTitleCellModel(identifier: "imageTitleCell",
                                                                                   title: "Filter 2", imageName: ""),
                                                            ImageTitleCellModel(identifier: "imageTitleCell",
                                                                                   title: "Filter 3", imageName: "")])]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        topViewHeight.constant = UIApplication.shared.statusBarFrame.height
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        registerCells()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "GradientSubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "gradientCell")
        tableView.register(UINib(nibName: "SubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "subtitleCell")
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "cardCell")
        tableView.register(UINib(nibName: "TopCardTableViewCell", bundle: nil), forCellReuseIdentifier: "topCardCell")
        tableView.register(UINib(nibName: "MiddleCardTableViewCell", bundle: nil), forCellReuseIdentifier: "middleCardCell")
        tableView.register(UINib(nibName: "BottomCardTableViewCell", bundle: nil), forCellReuseIdentifier: "bottomCardCell")
        tableView.register(UINib(nibName: "ContainerTableViewCell", bundle: nil), forCellReuseIdentifier: "containerCell")
        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "collectionCell")
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModels[indexPath.section][indexPath.row].identifier, for: indexPath)
        let cellModel = cellModels[indexPath.section][indexPath.row]
        if let subtitleCell = cell as? SubtitleTableViewCell, let subtitleCellModel = cellModel as? SubtitleCellModel {
            subtitleCell.titleLabel.text = subtitleCellModel.title
            subtitleCell.subtitleLabel.text = subtitleCellModel.subtitle
        } else if let collectionCell = cell as? CollectionTableViewCell, let collectionCellModel = cellModel as? CollectionCellModel {
            collectionCell.cellSize = collectionCellModel.cellSize
            collectionCell.cellModels = collectionCellModel.collectionCellModels
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
