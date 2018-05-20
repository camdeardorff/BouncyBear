//
//  extension-CGRect.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + size.width/2,
                       y: origin.y + size.height/2)
    }
}
