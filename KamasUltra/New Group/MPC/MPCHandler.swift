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
        
        //self.advertiser.delegate = self
        self.advertiser.startAdvertisingPeer()
        
        super.init()
        self.browser.delegate = self
        self.browser.startBrowsingForPeers()
    }
    
    deinit {
        self.browser.stopBrowsingForPeers()
    }
}

extension MPCHandler : MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if !Globals.shared.peers.contains(where: { $0.peerID == peerID }) {
            Globals.shared.peers.append(Peer(peerID: peerID))
        }
        
        //let userInfo = ["peerID": peerID] as [String : Any]
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: Notifications.MPCFoundPeer, object: nil, userInfo: nil)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        //print("Before: \(Globals.sharedManager.peers.count)")
        let peers = Globals.shared.peers.filter({$0.peerID != peerID})
        Globals.shared.peers = peers
        //print("After: \(Globals.sharedManager.peers.count)")
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: Notifications.MPCFoundPeer, object: nil, userInfo: nil)
        }
        
    }
}


