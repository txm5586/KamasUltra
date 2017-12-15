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
    
    // Related to P2P Connection Handler
    var mpchandler: MPCHandler = MPCHandler()
    
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

