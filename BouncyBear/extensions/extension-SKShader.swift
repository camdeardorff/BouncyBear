//
//  extension-SKShader.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit

extension SKShader {
    static func gradient(fromColor c1: UIColor, toColor c2: UIColor) -> SKShader {
        let shader = SKShader(fileNamed: "Gradient.fsh")
        let uniforms = [
            SKUniform(name: "bottomColor", vectorFloat4: c1.skColor.vec4),
            SKUniform(name: "topColor", vectorFloat4: c2.skColor.vec4)
        ]
        shader.uniforms = uniforms
        return shader
    }
}
