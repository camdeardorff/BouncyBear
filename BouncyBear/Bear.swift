//
//  Bear.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit

enum BearType: String {
    case panda = "🐼"
    case koala = "🐨"
    case brown = "🐻"
    
    func sprite() -> Bear {
        let bear = Bear(type: self)
        bear.type = self
        bear.fontSize = 64
        return bear
    }
}

protocol BearDelegate {
    func bearWasTouched(_: Bear)
}

class Bear: SKLabelNode {
    
    public var isJumping: Bool = false
    public var delegate: BearDelegate?
    public var type: BearType?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
    }
    
    init(type: BearType) {
        self.type = type
        super.init(fontNamed: "Chalkduster")
        self.text = type.rawValue
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(inDirection direction: Direction, toPoint finalPosition: CGPoint, withAnimation isAnimated: Bool, completion: @escaping ()->()) {
        isJumping = true
        
        var jumpAction: SKAction!
        var landAction: SKAction!
        
        let longAction: TimeInterval = isAnimated ? 0.2 : 0
        let shortAction: TimeInterval = isAnimated ? 0.05 : 0

        let jumpOffsetY: CGFloat = -(frame.height / 2) + 32
        
        switch direction {
        case .up:
            // jump
            let jumpPosition = finalPosition.offset(dx: 0, dy: jumpOffsetY)
            jumpAction = SKAction.move(to: jumpPosition, duration: longAction)
            jumpAction.timingMode = .easeOut
            // land
            let finalPosition = finalPosition.offset(dx: 0, dy: -(frame.height / 2))
            landAction = SKAction.move(to: finalPosition, duration: shortAction)
            landAction.timingMode = .easeIn
            
        case .down:
            // jump
            let jumpPosition = center.offset(dx: 0, dy: jumpOffsetY)
            jumpAction = SKAction.move(to: jumpPosition, duration: shortAction)
            jumpAction.timingMode = .easeOut
            // land
            let finalPosition = finalPosition.offset(dx: 0, dy: -(frame.height / 2))
            landAction = SKAction.move(to: finalPosition, duration: longAction)
            landAction.timingMode = .easeIn
        }

        
        // run actions
        let series = SKAction.sequence([jumpAction, landAction])
        self.run(series) { [weak self] in
            self?.isJumping = false
            completion()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began on bear")
        if let _ = touches.first {
            delegate?.bearWasTouched(self)
        }
    }
}
