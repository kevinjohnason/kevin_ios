//
//  KCCellModel.swift
//  kevin
//
//  Created by kevin.cheng on 6/25/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

protocol ContainerCell {
    var containerViewBackgroundColor: UIColor { get set }
}

class CellModel: Codable {
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
    
    private enum CodingKeys: String, CodingKey {
        case title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
}

class ImageTitleCellModel: TitleCellModel {
    let imageName: String
    
    private enum CodingKeys: String, CodingKey {
        case imageName
    }
    
    init(identifier: String, title: String, imageName: String) {
        self.imageName = imageName
        super.init(identifier: identifier, title: title)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageName, forKey: .imageName)
    }
}

class SubtitleCellModel: TitleCellModel {
    let subtitle: String
    
    private enum CodingKeys: String, CodingKey {
        case subtitle
    }
    
    init(identifier: String, title: String, subtitle: String) {
        self.subtitle = subtitle
        super.init(identifier: identifier, title: title)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subtitle, forKey: .subtitle)
    }
}

class ValueSubtitleCellModel: SubtitleCellModel {
    let value: Double
    
    private enum CodingKeys: String, CodingKey {
        case value
    }
    
    init(identifier: String, title: String, subtitle: String, value: Double) {
        self.value = value
        super.init(identifier: identifier, title: title, subtitle: subtitle)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode(Double.self, forKey: .value)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
    }
}

class CollectionCellModel: CellModel {
    let cellSize: CGSize
    var collectionCellModels: [TitleCellModel]
    
    private enum CodingKeys: String, CodingKey {
        case cellSize
        case collectionCellModels
    }
    
    init(identifier: String, cellSize: CGSize,
         collectionCellModels: [TitleCellModel]) {
        self.cellSize = cellSize
        self.collectionCellModels = collectionCellModels
        super.init(identifier: identifier)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cellSize = try container.decode(CGSize.self, forKey: .cellSize)
        self.collectionCellModels = try container.decode([ImageTitleCellModel].self, forKey: .collectionCellModels)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cellSize, forKey: .cellSize)
        try container.encode(collectionCellModels, forKey: .collectionCellModels)
    }
}

class ContainerCollectionCellModel: CollectionCellModel, ContainerCell {
    var containerViewBackgroundColor: UIColor
    
    private enum CodingKeys: String, CodingKey {
        case containerViewBackgroundColor
    }
    
    init(identifier: String, cellSize: CGSize,
         collectionCellModels: [TitleCellModel], containerViewBackgroundColor: UIColor) {
        self.containerViewBackgroundColor = containerViewBackgroundColor
        super.init(identifier: identifier, cellSize: cellSize, collectionCellModels: collectionCellModels)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let color = try container.decode(Color.self, forKey: .containerViewBackgroundColor)
        self.containerViewBackgroundColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green),
                                                    blue: CGFloat(color.blue), alpha: 1)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let colorComponents = containerViewBackgroundColor.cgColor.components else {
            return
        }        
        try container.encode(Color(red: Double(colorComponents[0]), green: Double(colorComponents[1]), blue: Double(colorComponents[2])), forKey: .containerViewBackgroundColor)
    }
}

struct Color: Codable {
    let red: Double
    let green: Double
    let blue: Double
}
