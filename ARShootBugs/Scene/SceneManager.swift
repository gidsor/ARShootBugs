//
//  SceneManager.swift
//  ARShootBugs
//
//  Created by Vadim Denisov on 26/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ARKit

class SceneManager {
    
    static let instance = SceneManager()
    
    private init() { }
    
    func loadScene(view: SKView, scene: SKScene) {
        
        if scene is VictoryScene || scene is DefeatScene {
            let revealGameScene = SKTransition.fade(withDuration: 0.5)
            scene.scaleMode = SKSceneScaleMode.aspectFill
            view.presentScene(scene, transition:revealGameScene)
        }
        
        if scene is GameScene {
            // make load new level or restart game
        }
    }
}
