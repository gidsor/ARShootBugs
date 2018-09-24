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
    
    var hasBugspray = false {
        didSet {
            let sightImageName = hasBugspray ? "bugspraySight" : "sight"
            sight.texture = SKTexture(imageNamed: sightImageName)
        }
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
            if node.name == NodeType.bug.rawValue || (node.name == NodeType.firebug.rawValue && hasBugspray) {
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
        
        hasBugspray = false
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
                
                let anchor = Anchor(transform: transform)
                if let name = node.name, let type = NodeType(rawValue: name) {
                    anchor.type = type
                    sceneView.session.add(anchor: anchor)
                    if anchor.type == .firebug {
                        addBugSpray(to: currentFrame)
                    }
                }
                
            }
        }
        
        isWorldSetup = true
    }
    
    private func addBugSpray(to currentFrame: ARFrame) {
        var translation = matrix_identity_float4x4
        translation.columns.3.x = Float(drand48() * 2 - 1)
        translation.columns.3.z = -Float(drand48() * 2 - 1)
        translation.columns.3.y = Float(drand48() - 0.5)
        let transform = currentFrame.camera.transform * translation
        
        let anchor = Anchor(transform: transform)
        anchor.type = .bugspray
        sceneView.session.add(anchor: anchor)
    }
    
    private func remove(bugspray anchor: ARAnchor) {
        run(Sounds.bugspray)
        sceneView.session.remove(anchor: anchor)
        hasBugspray = true
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
        
        for anchor in currentFrame.anchors {
            guard let node = sceneView.node(for: anchor), node.name == NodeType.bugspray.rawValue else { continue }
            let distance = simd_distance(anchor.transform.columns.3, currentFrame.camera.transform.columns.3)
            if distance < 0.1 {
                remove(bugspray: anchor)
                break
            }
        }
    }
}
