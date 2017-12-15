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
    private let serviceType = "kamasultraapp"//Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    private var peerID: MCPeerID
    private var session: MCSession!
    private let browser: MCNearbyServiceBrowser
    private var advertiser: MCNearbyServiceAdvertiser!
    
    var connectedTo: MCPeerID?
    
    override init() {
        self.peerID = MCPeerID(displayName: UIDevice.current.name + String(arc4random() % 10))
        self.advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        self.browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        self.session = MCSession(peer: peerID)
        
        super.init()
        
        self.advertiser.delegate = self
        self.advertiser.startAdvertisingPeer()
        
        self.browser.delegate = self
        self.browser.startBrowsingForPeers()
        
        self.session.delegate = self
    }
    
    deinit {
        self.advertiser.stopAdvertisingPeer()
        self.browser.stopBrowsingForPeers()
    }
    
    func advertiseSelf(advertise: Bool) {
        if advertise {
            self.advertiser.startAdvertisingPeer()
        } else {
            self.advertiser.stopAdvertisingPeer()
        }
    }
    
    func invitePeer(peerID: MCPeerID) {
        
        
        self.browser.invitePeer(self.peerID, to: self.session, withContext: nil, timeout: 10)
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

extension MPCHandler : MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if connectedTo != nil {
            invitationHandler(false, nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            //self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension MPCHandler : MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}


