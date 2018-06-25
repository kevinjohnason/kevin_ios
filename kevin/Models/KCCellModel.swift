//
//  KCCellModel.swift
//  kevin
//
//  Created by kevin.cheng on 6/25/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
class CellModel {
    let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }
}

class TitleCellModel: CellModel {
    let title: String
    init(identifier: String, title: String) {
        self.title = title
        super.init(identifier: identifier)
    }
}

class ImageTitleCellModel: TitleCellModel {
    let imageName: String
    init(identifier: String, title: String, imageName: String) {
        self.imageName = imageName
        super.init(identifier: identifier, title: title)
    }
}

class SubtitleCellModel: TitleCellModel {
    let subtitle: String
    init(identifier: String, title: String, subtitle: String) {
        self.subtitle = subtitle
        super.init(identifier: identifier, title: title)
    }
}

class ValueSubtitleCellModel: SubtitleCellModel {
    let value: Double
    init(identifier: String, title: String, subtitle: String, value: Double) {
        self.value = value
        super.init(identifier: identifier, title: title, subtitle: subtitle)
    }
}

class CollectionCellModel: CellModel {
    let cellSize: CGSize
    var collectionCellModels: [TitleCellModel]
    init(identifier: String, cellSize: CGSize,
         collectionCellModels: [TitleCellModel]) {
        self.cellSize = cellSize
        self.collectionCellModels = collectionCellModels
        super.init(identifier: identifier)
    }
    
}
