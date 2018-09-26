//
//  VictoryScene.swift
//  ARShootBugs
//
//  Created by Vadim Denisov on 26/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ARKit

class VictoryScene: SKScene {
    
    override func didMove(to view: SKView) {
        let loseNode = SKLabelNode(text: "You Win")
        loseNode.fontSize = 25
        loseNode.fontColor = UIColor.green
        loseNode.fontName = "San Fransisco"
        loseNode.position = CGPoint(x:frame.midX, y:frame.midY)
        scene?.addChild(loseNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.sceneView.presentScene(GameScene())
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
