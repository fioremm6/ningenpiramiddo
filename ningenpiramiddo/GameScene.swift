//
//  GameScene.swift
//  ningenpiramiddo
//
//  Created by 菊地桃々 on 2024/05/08.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        // 物理演算の設定
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        self.backgroundColor = SKColor.white
        let backGround = SKSpriteNode(imageNamed:"summer")
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
                backGround.size = self.size
//                self.addChild(backGround)
    }

    func add(image: UIImage) {
        let texture = SKTexture(image: image.resized(desiredSize: 500))
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: frame.midX, y: frame.maxY-100)
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        sprite.physicsBody?.isDynamic = true
        sprite.setScale(0.3)
        sprite.setup(with: .image)
        addChild(sprite)
    }
    
    func addBoard(){
        let size = CGSize(width: 300, height: 10)
        let node = SKSpriteNode(color: .blue, size: size)
        node.position = CGPoint(x: frame.midX, y: frame.maxY-100)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.isDynamic = true
        addChild(node)
        
    }
}


extension UIImage {
    func resized(desiredSize: CGFloat) -> UIImage {
        let scale = min(desiredSize / min(size.width, size.height), 1.0)
        if scale == 1.0 {
            return self
        }

        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
