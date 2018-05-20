//
//  GameScene.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit
import GameplayKit

enum Direction {
    case up
    case down
}

class GameScene: SKScene {
    
    // steps
    private var colors = UIColor.pastels
    private var steps: [Step] = []
    private var currentStep: Step?
    
    // bear
    public var bearType: BearType?
    private var bear: Bear!
    
    // swiping state
    private var moveAmtY: CGFloat = 0
    private let minimum_detect_distance: CGFloat = 100
    private var initialPosition: CGPoint = CGPoint.zero
    private var initialTouch: CGPoint = CGPoint.zero
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        let stepOverlap: CGFloat = 10
        let stepHeight = frame.height / CGFloat(colors.count)
        
        // for every color, create a step and add that to the view
        for i in 0..<colors.count {
            let rect = CGRect(x: frame.origin.x,
                              y: frame.origin.y + (CGFloat(i) * stepHeight),
                              width: frame.size.width,
                              height: stepHeight + stepOverlap)
            
            let step = Step(rect: rect, color: colors[i])
            steps.append(step)
            self.addChild(step)
        }
        
        // default to panda if the bear type was not specified
        bear = (bearType ?? BearType.panda).sprite()
        self.addChild(bear)
        if let firstStep = steps.first {
            moveBear(inDirection: .up, toStep: firstStep, withAnimation: false)
            currentStep = firstStep
        }
        
    }
    
    // make the bear jump to the step in the direction provided
    private func jump(inDirection direction: Direction) {
        // if the bear is currently jumping then don't bother
        if bear.isJumping { return }
        // get the current step and it's index in the steps list
        guard let step = currentStep,
            let idx = steps.index(of: step) else { return }
        // determine what step is next, given the direction
        let nextIdx = idx.advanced(by: (direction == .up ? 1 : -1))
        // move the bear to that step if it exists in the list
        // (can't jump above the top / can't jump below the bottom)
        if (steps.startIndex..<steps.endIndex).contains(nextIdx) {
            let nextStep = steps[nextIdx]
            moveBear(inDirection: direction, toStep: nextStep, withAnimation: true)
            currentStep = nextStep
        }
    }
    
    // sends the bear to the next step
    private func moveBear(inDirection direction: Direction, toStep step: Step, withAnimation animation: Bool) {
        if bear.isJumping { return }
        bear.move(inDirection: direction, toPoint: step.center, withAnimation: animation, completion: { [weak self] in
            self?.currentStep?.bounceOnStep()
        })
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// gestures and interactions
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            initialTouch = touch.location(in: self.scene!.view)
            moveAmtY = 0
            initialPosition = self.position
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let movingPoint: CGPoint = touch.location(in: self.scene!.view)
            moveAmtY = movingPoint.y - initialTouch.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if fabs(moveAmtY) > minimum_detect_distance {
            let direction: Direction = (moveAmtY < 0 ? .up : .down)
            jump(inDirection: direction)
        }
    }
}
