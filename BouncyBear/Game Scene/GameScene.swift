//
//  GameScene.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit
import GameplayKit
import ARKit

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
    
    // face tracking params
    let smileThreshold = 0.65
    let jawThreshold = 0.7
    
    // face tracking state
    var smileIsCurrentlyThere = false
    var jawIsCurrentlyOpen = false
    
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
        
        initFaceTracking()
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

// Face tracking stuff
extension GameScene: ARSCNViewDelegate {
    
    /// Initializes face tracking
    func initFaceTracking() {
        let configuration = ARFaceTrackingConfiguration()
        
        if let hostView = self.view {
            let sceneView = ARSCNView(frame: hostView.bounds)
            sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
            sceneView.isHidden = true
            sceneView.delegate = self
            
            hostView.addSubview(sceneView)
        }
    }
    
    /// Gets called when there are updates to the face 'mesh'
    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        
        let smileIsThere = checkSmile(faceAnchor: faceAnchor, threshold: smileThreshold)
        let jawIsOpen = checkJaw(faceAnchor: faceAnchor, threshold: jawThreshold)
        
        if smileIsCurrentlyThere != smileIsThere {
            smileIsCurrentlyThere = smileIsThere
            if smileIsThere {
                jump(inDirection: .up)
            }
        }
        else if jawIsCurrentlyOpen != jawIsOpen {
            jawIsCurrentlyOpen = jawIsOpen
            if jawIsOpen {
                jump(inDirection: .down)
            }
        }
    }
    
    /// Checks for a smile given a faceAnchor.
    ///
    /// - Parameter faceAnchor: the face anchor to check for a smile.
    /// - Parameter threshold: the the threshold of the smile coefficient.
    /// - Returns: true or false, indicating whether a smile was detected.
    func checkSmile(faceAnchor: ARFaceAnchor, threshold: Double) -> Bool {
        let blendShapes = faceAnchor.blendShapes
        
        if let smileLeftValue = blendShapes[.mouthSmileLeft], let smileRightValue = blendShapes[.mouthSmileRight] {
            return ((smileLeftValue.doubleValue + smileRightValue.doubleValue) / 2.0) >= threshold
        }
        
        return false
    }
    
    /// Checks whether the jaw is open given a faceAnchor.
    ///
    /// - Parameter faceAnchor: the face anchor to check for an open jaw.
    /// - Parameter threshold: the the threshold of the jaw-open coefficient.
    /// - Returns: true or false, indicating whether an open jaw was detected.
    func checkJaw(faceAnchor: ARFaceAnchor, threshold: Double) -> Bool {
        let blendShapes = faceAnchor.blendShapes
        
        if let jawOpenValue = blendShapes[.jawOpen] {
            return jawOpenValue.doubleValue >= threshold
        }
        
        return false
    }
}
