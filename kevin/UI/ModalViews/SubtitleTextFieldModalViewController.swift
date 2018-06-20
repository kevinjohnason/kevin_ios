//
//  SubtitleTextFieldModalViewController.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
import RxSwift
class SubtitleTextFieldModalViewController: SubtitleModalViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var inputLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var textFieldViewModel: SubtitleTextFieldViewModel? {
        return viewModel as? SubtitleTextFieldViewModel
    }
    
    fileprivate var keybaordHeight: CGFloat = 0
    
    override var modalPosition: CGFloat {
        return keybaordHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    override func setupObservables() {
        super.setupObservables()
        guard let viewModel = textFieldViewModel else {
            return
        }
        textField.rx.text.bind(to: viewModel.textFieldText)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.textFieldText
            .map {  ($0?.count ?? 0) > 0 }
            .asDriver(onErrorJustReturn: false)
            .drive(confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(Notification.Name.UIKeyboardWillShow)
            .takeUntil(rx.methodInvoked(#selector(viewWillDisappear(_:))))
            .map { notification in
                guard let userInfo = notification.userInfo else {
                    return 0
                }
                guard let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                    return 0
                }
                return keyboardSize.height
            }.do(onNext: { [unowned self] height in
                self.keybaordHeight = height
            })
            .bind(to: self.modalBottomConstraint.rx.constant)
            .disposed(by: disposeBag)
    }
    
    override func initScrollingAnimation() {
        
    }
    
}

