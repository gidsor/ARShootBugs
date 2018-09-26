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
    
    var sceneView: ARSKView?
    
    private init() { }
    
    func loadScene(scene: SKScene) {
        
        if scene is VictoryScene || scene is DefeatScene {
            if let view = sceneView {
                let revealGameScene = SKTransition.fade(withDuration: 0.5)
                scene.size = view.bounds.size
                scene.scaleMode = SKSceneScaleMode.aspectFill
                view.presentScene(scene, transition:revealGameScene)
            }
        }
        
        if scene is GameScene {
            if let view = sceneView {
                
                if let configuration = sceneView?.session.configuration {
                    sceneView?.session.run(configuration, options: .resetTracking)
                }
                
                scene.size = view.bounds.size
                scene.scaleMode = .resizeFill
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                view.presentScene(scene)
            }
        }
    }
}
