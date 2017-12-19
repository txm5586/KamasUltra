//
//  PlayViewController.swift
//  KamasUltra
//
//  Created by Tassio Moreira Marques on 14/12/2017.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    private var appDelegate: AppDelegate!
    
    var mpcHandlerService: MPCHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        mpcHandlerService = self.appDelegate.mpcHandler
        mpcHandlerService.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlayViewController.receivedData(notification:)),
                                               name:Notifications.MPCReceiveData, object: nil);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedChangeBack(_ sender: Any) {
        self.mpcHandlerService.sendData()
    }
    
    @objc func receivedData(notification: NSNotification) {
        self.view.backgroundColor = UIColor.green
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayViewController : MPCHandlerDelegate {
    func connectedDevicesChanged(manager: MPCHandler, connectedDevices: [String]) {
        
    }
    
    func sendData(manager: MPCHandler) {
        self.view.backgroundColor = UIColor.brown
    }
}
