//
//  NodeType.swift
//  ningenpiramiddo
//
//  Created by 菊地桃々 on 2024/05/08.
//

import Foundation
import SpriteKit

enum NodeType: UInt32 {
    case image = 1 //二倍
    
    var categoryBitMask: UInt32 {
        return rawValue
    }
    
    var collisionBitMask: UInt32 {
        switch self {
        case .image:
            NodeType.image.categoryBitMask
        }
    }
    var contactBitMask:UInt32 {
        switch self {
        case .image:
            NodeType.image.categoryBitMask
        }
    }
}

extension SKNode{
    func setup(with nodeType:NodeType){
        physicsBody?.categoryBitMask = nodeType.categoryBitMask
        physicsBody?.collisionBitMask = nodeType.collisionBitMask
        physicsBody?.contactTestBitMask = nodeType.contactBitMask
    }
}
