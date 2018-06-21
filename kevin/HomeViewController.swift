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
    let sectionCells: [[String]] = [["gradientCell"], ["subtitleCell", "subtitleCell"],
                                    ["cardCell"],
                                    ["topCardCell", "middleCardCell", "bottomCardCell"]]
    let subtitles: [[(String, String)]] = [[("Hello from Kevin", "Today is another nice day!!")],
                                           [("You have ran", "100 miles"), ("You have consumed", "100 calories")],
                                           [("You are all kinds of awesome!", "No kidding!")],
                                           [("Chipolte", "$10.99"),("KFC", "$12.95"),("Dig Inn", "$13.95")]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
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
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionCells[indexPath.section][indexPath.row], for: indexPath)
        if let subtitleCell = cell as? SubtitleTableViewCell {
            subtitleCell.titleLabel.text = subtitles[indexPath.section][indexPath.row].0
            subtitleCell.subtitleLabel.text = subtitles[indexPath.section][indexPath.row].1
        }
        return cell
        
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

