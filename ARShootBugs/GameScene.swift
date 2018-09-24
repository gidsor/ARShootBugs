//
//  GameScene.swift
//  ARShootBugs
//
//  Created by Vadim Denisov on 24.09.2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ARKit

class GameScene: SKScene {

    var sceneView: ARSKView {
        return view as! ARSKView
    }
    
    var isWorldSetup = false
    
    private func setupWorld() {
        guard let currentFrame = sceneView.session.currentFrame else { return }
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.3
        
        let transform = currentFrame.camera.transform * translation
        
        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
        
        isWorldSetup = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !isWorldSetup {
            setupWorld()
        }
    }
}
