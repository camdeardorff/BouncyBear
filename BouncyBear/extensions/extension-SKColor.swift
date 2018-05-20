//
//  extension-SKColor.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit

extension SKColor {
    var vec4: vector_float4 {
        return vector_float4(Float(components.red),
                             Float(components.green),
                             Float(components.blue),
                             Float(components.alpha))
    }
}

