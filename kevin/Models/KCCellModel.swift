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

protocol Typable: Codable {
    var type: String { get }
}

extension Typable {
    var type: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}

enum TypeKey: String, CodingKey {
    case type
}

extension String {
    var typeClass: AnyObject.Type {
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        return NSClassFromString("\(appName).\(self)") ?? AnyObject.self
    }
}

class Screen: Codable {
    var sections: [[CellModel]] = []
    
    private enum CodingKeys: String, CodingKey {
        case sections
    }
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        var sections: [[CellModel]] = []
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var sectionArrayForType = try container.nestedUnkeyedContainer(forKey: .sections)
        while !sectionArrayForType.isAtEnd {
           var rowArrayForType = try sectionArrayForType.nestedUnkeyedContainer()
           var tmpArrayForType = rowArrayForType
           var rows: [CellModel] = []
           while !rowArrayForType.isAtEnd {
                let typeContainer = try rowArrayForType.nestedContainer(keyedBy: TypeKey.self)
                let typeStr = try typeContainer.decode(String.self, forKey: TypeKey.type)
                guard let cellType = CellModel.subClassType(typeStr) as? CellModel.Type else {
                    continue
                }
                let cellModel = try tmpArrayForType.decode(cellType)
                rows.append(cellModel)
            }
            sections.append(rows)
        }
        self.sections =  sections
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sections, forKey: .sections)
    }
}

class CellModel: Codable, Typable {
    let identifier: String
    var showBottomBorder: Bool = false
    private enum CodingKeys: String, CodingKey {
        case identifier
        case type
        case showBottomBorder
    }
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(String.self, forKey: .identifier)
        if container.contains(.showBottomBorder) {
            self.showBottomBorder = try container.decode(Bool.self, forKey: .showBottomBorder)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(type, forKey: .type)
    }
    
    static func subClassType(_ typeStr: String) -> AnyObject.Type {
        var type = CellModel.self
        switch typeStr {
        case "TitleCellModel":
            type = TitleCellModel.self
        case "ImageTitleCellModel":
            type = ImageTitleCellModel.self
        case "ImageSubtitleCellModel":
            type = ImageSubtitleCellModel.self
        case "SubtitleCellModel":
            type = SubtitleCellModel.self
        case "ValueSubtitleCellModel":
            type = ValueSubtitleCellModel.self
        case "CollectionCellModel":
            type = CollectionCellModel.self
        case "ContainerCollectionCellModel":
            type = ContainerCollectionCellModel.self
        default:
            break
        }
        return type
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

class ImageSubtitleCellModel: SubtitleCellModel {
    let imageName: String
    
    private enum CodingKeys: String, CodingKey {
        case imageName
    }
    
    init(identifier: String, title: String, subtitle: String, imageName: String) {
        self.imageName = imageName
        super.init(identifier: identifier, title: title, subtitle: subtitle)
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
        var collectionContainer = try container.nestedUnkeyedContainer(forKey: .collectionCellModels)
        var tmpContainer = collectionContainer
        var cellModels: [TitleCellModel] = []
        while !collectionContainer.isAtEnd {
            let cellContainer = try collectionContainer.nestedContainer(keyedBy: TypeKey.self)
            let typeStr = try cellContainer.decode(String.self, forKey: TypeKey.type)
            guard let type = CellModel.subClassType(typeStr) as? TitleCellModel.Type else {
                continue
            }
            cellModels.append(try tmpContainer.decode(type))
        }        
        self.collectionCellModels = cellModels
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
        try container.encode(Color(red: Double(colorComponents[0]),
                                   green: Double(colorComponents[1]),
                                   blue: Double(colorComponents[2])),
                                   forKey: .containerViewBackgroundColor)
    }
}

struct Color: Codable {
    let red: Double
    let green: Double
    let blue: Double
}
