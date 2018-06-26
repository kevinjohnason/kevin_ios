//
//  AppDataSource.swift
//  kevin
//
//  Created by kevin.cheng on 6/26/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import Foundation
import RxSwift

class AppDataSource {
    
    func loadHomeModelCells() -> Observable<[[CellModel]]> {
        return Observable<[[CellModel]]>.create { observable in
            guard let url = Bundle.main.url(forResource: "home", withExtension: "json") else {
                observable.onError(APIError.invalidUrl)
                return Disposables.create()
            }
            guard let data = try? Data(contentsOf: url) else {
                observable.onError(APIError.invalidUrl)
                return Disposables.create()
            }
            guard let cellModels = try? JSONDecoder().decode([[CellModel]].self, from: data) else {
                observable.onError(APIError.invalidFormat(type: [[CellModel]].self, value: data))
                return Disposables.create()
            }
            observable.onNext(cellModels)
            observable.onCompleted()
            return Disposables.create()
        }
    }
        
}
