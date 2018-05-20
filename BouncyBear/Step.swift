//
//  Level.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit

class Step: SKShapeNode {
    
    init(rect: CGRect, color: UIColor) {
        super.init()
        path = CGPath.trapezoid(inRect: rect, cutIn: rect.width/10)
        fillShader = SKShader.gradient(fromColor: color.lighter(), toColor: color.darker())
        strokeColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bounceOnStep() {
        let jutOutAction = SKAction.moveBy(x: 0, y: -10, duration: 0.1)
        let returnInAction = jutOutAction.reversed()
        self.run(SKAction.sequence([jutOutAction, returnInAction]))
    }
}
