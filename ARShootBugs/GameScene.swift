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
    var sight: SKSpriteNode!
    let gameSize = CGSize(width: 2, height: 2)
    
    override func didMove(to view: SKView) {
        sight = SKSpriteNode(imageNamed: "sight")
        addChild(sight)
        srand48(Int(Date.timeIntervalSinceReferenceDate))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = sight.position
        let hitNodes = nodes(at: location)
        
        var hitBug: SKNode?
        for node in hitNodes {
            if node.name == "bug" {
                hitBug = node
                break
            }
        }
        
        run(Sounds.fire)
        if let hitBug = hitBug, let anchor = sceneView.anchor(for: hitBug) {
            let action = SKAction.run {
                self.sceneView.session.remove(anchor: anchor)
            }
            let group = SKAction.group([Sounds.hit, action])
            let sequence = [SKAction.wait(forDuration: 0.3), group]
            hitBug.run(SKAction.sequence(sequence))
        }
    }
    
    private func setupWorld() {
        guard let currentFrame = sceneView.session.currentFrame, let scene = SKScene(fileNamed: "Level1") else { return }
        
        for node in scene.children {
            if let node = node as? SKSpriteNode {
                var translation = matrix_identity_float4x4
                let positionX = node.position.x / scene.size.width
                let positionY = node.position.y / scene.size.height
                translation.columns.3.x = Float(positionX * gameSize.width)
                translation.columns.3.z = -Float(positionY * gameSize.height)
                translation.columns.3.y = Float(drand48() - 0.5)
                let transform = currentFrame.camera.transform * translation
                let anchor = ARAnchor(transform: transform)
                sceneView.session.add(anchor: anchor)
            }
        }
        
        isWorldSetup = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !isWorldSetup {
            setupWorld()
        }
        
        guard let currentFrame = sceneView.session.currentFrame,
            let lightEstimate = currentFrame.lightEstimate else {
                return
        }
        
        let neutralIntensity: CGFloat = 1000
        let ambientIntensity = min(lightEstimate.ambientIntensity, neutralIntensity)
        let blendFactor = 1 - ambientIntensity / neutralIntensity
        
        for node in children {
            if let bug = node as? SKSpriteNode {
                bug.color = .black
                bug.colorBlendFactor = blendFactor
            }
        }
    }
}
