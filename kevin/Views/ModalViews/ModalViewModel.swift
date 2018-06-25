//
//  ModalViewModel.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SubtitleModalViewModel {
    
    var disposeBag = DisposeBag()
    
    var title: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var subtitle: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var status: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var confirmButtonTitle: BehaviorRelay<String?> = BehaviorRelay(value: "Okay")
    
    var confirmButtonPressed: PublishRelay<Bool> = PublishRelay()
    
    var dismissModal: PublishRelay<Bool> = PublishRelay()
    
    var disable: PublishRelay<Bool> = PublishRelay()
    
    var showDisable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
}

class SubtitleTextFieldViewModel: SubtitleModalViewModel {
    
    var textFieldText: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
}
