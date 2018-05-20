//
//  MenuScene.swift
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        // create a container for the bears to sit in waiting for selection
        let containterSize = CGSize(width: size.width - 64, height: size.height / 4)
        let rect = CGRect(origin: CGPoint(x: frame.origin.x + size.width/2 - containterSize.width/2,
                                          y: frame.origin.y + size.height/2 - containterSize.height/2),
                          size: containterSize)
        let selectionContainer = SKShapeNode(rect: rect, cornerRadius: 32)
        selectionContainer.fillShader = SKShader.gradient(fromColor: .pastelOrange, toColor: .pastelPink)
        selectionContainer.strokeColor = .clear
        addChild(selectionContainer)
        
        // position the bears on the creases as if the container was folded into fourths
        let fourths = containterSize.width/4
        
        let panda = BearType.panda.sprite()
        panda.position = CGPoint(x: -fourths, y: -panda.frame.size.height/2)
        panda.delegate = self
        selectionContainer.addChild(panda)
        
        let koala = BearType.koala.sprite()
        koala.position = CGPoint(x: 0, y: -koala.frame.size.height/2)
        koala.delegate = self
        selectionContainer.addChild(koala)
        
        let brown = BearType.brown.sprite()
        brown.position = CGPoint(x: fourths, y: -brown.frame.size.height/2)
        brown.delegate = self
        selectionContainer.addChild(brown)
        
        // selection label positioned just above the container
        let selectLabel = SKLabelNode(text: "Pick Your Bear")
        selectLabel.position = rect.center.offset(dx: 0, dy: rect.height/2 + 48)
        selectLabel.horizontalAlignmentMode = .center
        selectLabel.fontSize = 36
        addChild(selectLabel)
        
        // title for the game above the selection label
        let gameLabel = SKLabelNode(text: "Bouncy Bear")
        gameLabel.position = selectLabel.frame.center.offset(dx: 0, dy: selectLabel.frame.height + 16)
        gameLabel.horizontalAlignmentMode = .center
        gameLabel.fontSize = 56
        addChild(gameLabel)
    }
}

extension MenuScene: BearDelegate {
    func bearWasTouched(_ bear: Bear) {
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.size = self.size
            scene.bearType = bear.type
            // Present the scene
            view?.presentScene(scene, transition: SKTransition.doorway(withDuration: 0.5))
        }
    }
}
