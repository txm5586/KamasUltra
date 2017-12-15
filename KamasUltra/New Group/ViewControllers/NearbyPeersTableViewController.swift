//
//  NearbyPeersTableViewController.swift
//  KamasUltra
//
//  Created by Tassio Moreira Marques on 14/12/2017.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class NearbyPeersTableViewController: UITableViewController {
    private var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(NearbyPeersTableViewController.foundPeer(notification:)),
                                               name:Notifications.MPCFoundPeer, object: nil);
        
        self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Handles table found and lost peers notifications
    
    @objc func foundPeer(notification: NSNotification) {
        self.tableView.reloadData()
        
        /*
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        let peerID = userInfo.object(forKey: "peerID") as! MCPeerID
        
        print("We are in: \(peerID.displayName)")
        
        appDelegate.peers.append(Peer(peerID: peerID))
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: appDelegate.peers.count-1, section: 0)], with: .automatic)
        self.tableView.endUpdates()*/
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Globals.shared.peers.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NearbyPeersTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NearbyPeersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of NearbyPeersTableViewCell.")
        }
        
        // Configure the cell...
        let peer = Globals.shared.peers[indexPath.row]
        
        cell.peerNameLabel.text = peer.peerID.displayName
        cell.stateLabel.text = "Connected"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

