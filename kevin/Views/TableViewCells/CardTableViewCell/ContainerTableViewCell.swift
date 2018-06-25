//
//  ContainerTableViewCell.swift
//  kevin
//
//  Created by kevin.cheng on 6/22/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class ContainerTableViewCell: UITableViewCell {

    lazy var innerViewController: UIViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "KCCollectionViewController")
    }()
    
    var cellHeight: CGFloat = 250
    
    @IBOutlet weak var containerView: RoundView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInnerViewController()
    }
    
    func setupInnerViewController() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15).isActive = true
        containerView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 15).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15).isActive = true
        containerView.addSubview(innerViewController.view)
        
        innerViewController.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: cellHeight)
        innerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        //innerViewController.view.heightAnchor.constraint(equalToConstant: cellHeight).isActive = true
        innerViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        innerViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        innerViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        innerViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        innerViewController.loadViewIfNeeded()
    }    
}
