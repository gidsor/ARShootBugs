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
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
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
}
