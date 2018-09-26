//
//  VictoryScene.swift
//  ARShootBugs
//
//  Created by Vadim Denisov on 26/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ARKit

class VictoryScene: SKScene {
    
    let winLabel = SKLabelNode(fontNamed: "Chalkduster")
    let newLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    override func sceneDidLoad() {
        winLabel.text = "You Win!"
        winLabel.fontSize = 60
        winLabel.fontColor = SKColor.green
        
        newLabel.text = "Tap to continue"
        newLabel.fontSize = 30
        newLabel.fontColor = SKColor.green
        
        run(Sounds.win)
    }
    
    override func didMove(to view: SKView) {
        winLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        newLabel.position = CGPoint(x:frame.midX, y: frame.midY - 60)
        
        addChild(winLabel)
        addChild(newLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SceneManager.instance.loadScene(scene: GameScene())
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
