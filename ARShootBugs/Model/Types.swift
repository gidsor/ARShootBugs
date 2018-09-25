//
//  Types.swift
//  ARShootBugs
//
//  Created by Vadim Denisov on 24.09.2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import SpriteKit

enum NodeType: String {
    case bug = "bug"
    case firebug = "firebug"
    case bugspray = "bugspray"
}

enum Sounds {
    static let fire =     SKAction.playSoundFileNamed("sprayBug", waitForCompletion: false)
    static let hit =      SKAction.playSoundFileNamed("hitBug", waitForCompletion: false)
    static let bugspray = SKAction.playSoundFileNamed("catchBugspray", waitForCompletion: false)
    static let win =      SKAction.playSoundFileNamed("win.wav", waitForCompletion: false)
    static let lose =     SKAction.playSoundFileNamed("lose.wav", waitForCompletion: false)
}


