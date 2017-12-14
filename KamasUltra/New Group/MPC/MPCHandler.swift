//
//  MPCHandler.swift
//  KamasUltra
//
//  Created by Tassio Moreira Marques on 14/12/2017.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MPCHandler: NSObject {
    private let serviceType = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    private var peerID: MCPeerID
    private var session: MCSession!
    
    private let browser: MCNearbyServiceBrowser
    private var advertiser: MCNearbyServiceAdvertiser!
    
    override init() {
        self.peerID = MCPeerID(displayName: UIDevice.current.name + String(arc4random() % 10))
        self.advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        self.browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        super.init()
        
        //self.advertiser.delegate = self
        self.advertiser.startAdvertisingPeer()
        
        self.browser.delegate = self
        self.browser.startBrowsingForPeers()
    }
    
    deinit {
        self.browser.stopBrowsingForPeers()
    }
}

extension MPCHandler : MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        let userInfo = ["peerID": peerID] as [String : Any]
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: Notifications.MPCFoundPeer, object: nil, userInfo: userInfo)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
}


