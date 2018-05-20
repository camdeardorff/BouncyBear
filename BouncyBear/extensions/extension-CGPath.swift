//
//  extension-CGPath.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import UIKit

extension CGPath {
    
    static func trapezoid(inRect rect: CGRect, cutIn: CGFloat) -> CGPath {
        let path = CGMutablePath()
        path.move(to: rect.origin)
        path.addLine(to: CGPoint(x: rect.origin.x + rect.size.width,
                                 y: rect.origin.y + 0))
        path.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - cutIn,
                                 y: rect.origin.y + rect.size.height))
        path.addLine(to: CGPoint(x: rect.origin.x + cutIn,
                                 y: rect.origin.y + rect.size.height))
        path.addLine(to: rect.origin)
        path.closeSubpath()
        return path
    }
}
