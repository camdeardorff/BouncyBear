//
//  extension-CGPoint.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import UIKit

extension CGPoint {
    /**
     * Adds (dx, dy) to the point.
     */
    
    public func offset(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx,
                      y: self.y + dy)
    }
}
