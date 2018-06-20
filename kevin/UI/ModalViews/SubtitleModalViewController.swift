//
//  SubtitleModalViewController.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SubtitleModalViewController: UIViewController {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var disableStackView: UIStackView!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var modalBottomConstraint: NSLayoutConstraint!
    var viewModel: SubtitleModalViewModel!
    var modalPosition: CGFloat {
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
        modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.isUserInteractionEnabled = true
        let panGeasture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        modalView.addGestureRecognizer(panGeasture)
        initScrollingAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if sender.state == .ended {
            if modalView.frame.size.height + modalBottomConstraint.constant > modalView.frame.size.height / 2 {
                animateScroll(to: self.modalPosition)
            } else {
                self.animateScroll(to: -self.modalView.frame.size.height) {
                    if $0 {
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            }
            return
        }
        modalBottomConstraint.constant -= translation.y
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func setupObservables() {
        cancelButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: viewModel.disposeBag)
        
        confirmButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.viewModel.confirmButtonPressed.accept(true)
        }).disposed(by: viewModel.disposeBag)
        
        if switchView != nil {
            switchView.rx.value.bind(to: viewModel.disable)
                .disposed(by: viewModel.disposeBag)
            
            viewModel.showDisable.map { !$0 }
                .asDriver(onErrorJustReturn: true)
                .drive(disableStackView.rx.isHidden)
                .disposed(by: viewModel.disposeBag)
        }
        
        viewModel.dismissModal.subscribe(onNext: { [unowned self] animated in
            self.dismiss(animated: animated, completion: nil)
        }).disposed(by: viewModel.disposeBag)
        
        viewModel.title.asDriver()
            .drive(titleLabel.rx.text)
            .disposed(by: viewModel.disposeBag)
        viewModel.subtitle.asDriver()
            .drive(subtitleLabel.rx.text)
            .disposed(by: viewModel.disposeBag)
        viewModel.confirmButtonTitle.asDriver()
            .drive(confirmButton.rx.title(for: .normal))
            .disposed(by: viewModel.disposeBag)
    }
    
    func initScrollingAnimation() {
        modalBottomConstraint.constant = -modalView.frame.size.height
        delay(0.1) {
            self.animateScroll(to: self.modalPosition)
        }
    }
    
    fileprivate func animateScroll(to position: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.modalBottomConstraint.constant = position
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
}
