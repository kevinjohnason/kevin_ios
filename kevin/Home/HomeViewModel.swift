//
//  HomeViewModel.swift
//  kevin
//
//  Created by kevin.cheng on 6/26/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class HomeViewModel {
    
    let cellModels: BehaviorRelay<[[CellModel]]> = BehaviorRelay(value: [])
    
    let dataSource: AppDataSource = AppDataSource()
    
    let disposeBag = DisposeBag()
    
    func loadCells() {
        dataSource.loadHomeModelCells().debug("cells")
            .bind(to: cellModels)
            .disposed(by: disposeBag)
    }
    
}
