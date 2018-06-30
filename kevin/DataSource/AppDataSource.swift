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
    //        let screen = Screen()
    //        screen.sections = cellModels
    //
    //        let data = try? JSONEncoder().encode(screen)
    //        print(String(data: data ?? Data(), encoding: .utf8) ?? "")
    
    
    
//    let chartCellModels = [ValueSubtitleCellModel(identifier: "verticalBarCell",
//                                                  title: "Cholote", subtitle: "", value: 0.1),
//                           ValueSubtitleCellModel(identifier: "verticalBarCell",
//                                                  title: "Peanut", subtitle: "", value: 0.5),
//                           ValueSubtitleCellModel(identifier: "verticalBarCell",
//                                                  title: "Candy", subtitle: "", value: 0.35)]
//
//    let optionCellModels = [ImageTitleCellModel(identifier: "imageTitleCell",
//                                                title: "Filter 1", imageName: "burger-blue"),
//                            ImageTitleCellModel(identifier: "imageTitleCell",
//                                                title: "Filter 2", imageName: "coffee-blue"),
//                            ImageTitleCellModel(identifier: "imageTitleCell",
//                                                title: "Filter 3", imageName: "imac-blue")]
//
//    lazy var cellModels: [[CellModel]] = [[SubtitleCellModel(identifier: "gradientCell", title: "Hello from Kevin",
//                                                             subtitle: "Today is another nice day!!")],
//                                          [SubtitleCellModel(identifier: "subtitleCell", title: "You have ran", subtitle: "100 miles"),
//                                           SubtitleCellModel(identifier: "subtitleCell", title: "You have consumed", subtitle: "100 calories")],
//                                          [SubtitleCellModel(identifier: "cardCell", title: "You are all kinds of awesome!", subtitle: "No kidding!")],
//                                          [SubtitleCellModel(identifier: "topCardCell", title: "Grocery", subtitle: "$33"),
//                                           SubtitleCellModel(identifier: "middleCardCell", title: "Restaurant", subtitle: "$148"),
//                                           SubtitleCellModel(identifier: "bottomCardCell", title: "Education", subtitle: "$321")],
//                                          [CollectionCellModel(identifier: "collectionCell", cellSize: CGSize(width: 60, height: 150),
//                                                               collectionCellModels: chartCellModels)],
//                                          [ContainerCollectionCellModel(identifier: "collectionCell", cellSize: CGSize(width: 100, height: 100),
//                                                                        collectionCellModels: optionCellModels,
//                                                                        containerViewBackgroundColor: UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1))]
//    ]
    

    func loadHomeModelCells() -> Observable<Screen> {
        return Observable<Screen>.create { observable in
            guard let url = Bundle.main.url(forResource: "home", withExtension: "json") else {
                observable.onError(APIError.invalidUrl)
                return Disposables.create()
            }
            guard let data = try? Data(contentsOf: url) else {
                observable.onError(APIError.invalidUrl)
                return Disposables.create()
            }
            guard let cellModels = try? JSONDecoder().decode(Screen.self, from: data) else {
                observable.onError(APIError.invalidFormat(type: Screen.self, value: data))
                return Disposables.create()
            }
            observable.onNext(cellModels)
            observable.onCompleted()
            return Disposables.create()
        }
    }
        
}
