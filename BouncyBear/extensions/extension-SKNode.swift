//
//  extension-SKNode.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit

extension SKNode {
    var center: CGPoint {
        return CGPoint(x: frame.origin.x + frame.width / 2,
                       y: frame.origin.y + frame.height / 2)
    }
}
