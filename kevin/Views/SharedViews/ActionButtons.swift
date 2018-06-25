//
//  ActionButtons.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class PendableButton: RoundButton {
    var disposeBag = DisposeBag()
    var spinner: UIActivityIndicatorView?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rx.tap.subscribe(onNext: { _ in
            self.isEnabled = false
            NotificationCenter.default.addObserver(self, selector: #selector(PendableButton.finishPending),
                                                   name: Notification.Name("finishLoading"), object: nil)
            self.addSpinner()
        }).disposed(by: disposeBag)
    }
    
    @objc func finishPending() {
        DispatchQueue.main.async {
            self.isEnabled = true
            self.spinner?.stopAnimating()
            self.spinner?.removeFromSuperview()
        }
        NotificationCenter.default.removeObserver(self, name: Notification.Name("finishLoading"), object: nil)
    }
    
    fileprivate func addSpinner() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        activityIndicator.startAnimating()
        spinner = activityIndicator
    }
    
}
