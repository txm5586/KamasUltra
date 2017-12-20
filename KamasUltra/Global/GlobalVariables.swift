//
//  GlobalVariables.swift
//  KamasUltra
//
//  Created by Tassio Moreira Marques on 15/12/2017.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import Foundation

class Globals {
    // These are the properties you can store in your singleton
    var peers = [Peer]()
    
    enum state : String {
        case connected = "Connected"
        case connecting = "Connecting"
        case declined = "Declined"
    }
    
    var selectedAction : Action!
    var selectedBodyPart : BodyPart!
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var shared: Globals {
        struct Static {
            static let instance = Globals()
        }
        return Static.instance
    }
}

// MARK: Constatants
enum Action : Int {
    case kiss = 0
    case lick = 1
    case suck = 2
    case touch = 3
    case random = 4
}

enum BodyPart : String {
    case Head
    case Ears
    case Mouth
    case Neck
    case Shoulders
    case Chest
    case Arms
    case Abdomin
    case Waist
    case Hands
    case Legs
    case Knees
    case Feet
}

