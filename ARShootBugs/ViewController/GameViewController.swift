//
//  GameViewController.swift
//  ARShootBugs
//
//  Created by Vadim Denisov on 24.09.2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import ARKit

class GameViewController: UIViewController {
  
    var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as? ARSKView {
            sceneView = view
            sceneView.delegate = self
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.presentScene(scene)
            
            view.showsFPS = true
            //view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.pause()
    }
}

extension GameViewController: ARSKViewDelegate {
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        var node: SKNode?
        if let anchor = anchor as? Anchor {
            if let type = anchor.type {
                node = SKSpriteNode(imageNamed: type.rawValue)
                node?.name = type.rawValue
            }
        }
        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("Session Failed - probably due to lack of camera access")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("Session interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("Session resumed")
        sceneView.session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
    }
}
