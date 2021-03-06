//
//  SubtitleTableViewCell.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
import RxSwift

enum ActionButtonType: Int {
    case close = 0
    case confirm = 1
    case cancel = 2
    case next = 3
    case back = 4
}

protocol ActionButtonCell {
    var actionButtons: [UIButton]? { get set }
    func actionButton(of type: ActionButtonType) -> UIButton?
}

extension ActionButtonCell {
    func actionButton(of type: ActionButtonType) -> UIButton? {
        return actionButtons?.first { type.rawValue == $0.tag }
    }
}

class PassThroughTableView: UITableView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}

class SubtitleTableViewCell: UITableViewCell {
    var disposeBag: DisposeBag = DisposeBag()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    var bottomBorder: CALayer?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        bottomBorder?.removeFromSuperlayer()
        bottomBorder = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder?.frame = CGRect(x: 15, y: self.frame.size.height - 1, width: self.frame.size.width - 30, height: 1)
    }
    
    func showBottomBorder() {
        if self.bottomBorder != nil {
            return
        }
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor(red: 227/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1).cgColor
        contentView.layer.addSublayer(bottomBorder)
        self.bottomBorder = bottomBorder
    }
    
}

class ImageSubtitleTableViewCell: SubtitleTableViewCell {
    @IBOutlet weak var cellImageView: UIImageView?
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
}

class SubtitleActionTableViewCell: SubtitleTableViewCell, ActionButtonCell {
    
    @IBOutlet var actionButtons: [UIButton]?
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBInspectable var topRoundCorner: Bool = false
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if topRoundCorner {
            contentView.layer.cornerRadius = 6
            contentView.layer.masksToBounds = true
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            layer.shadowOffset = CGSize(width: 0, height: -2)
            layer.shadowOpacity = 0.05
            layer.shadowRadius = 3
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

class ButtonTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var button: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}

class SearchBarTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupObservables()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        setupObservables()
    }
    
    fileprivate func setupObservables() {
        cancelButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.searchBar.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
}
