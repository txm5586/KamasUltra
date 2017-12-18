//
//  WaitingForPartnerViewController.swift
//  KamasUltra
//
//  Created by Cristiano Maria Coppotelli on 15/12/17.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit

class WaitingForPartnerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let cardiogramPulse = CASpringAnimation(keyPath: "transform.scale")
        cardiogramPulse.duration = 0.6
        cardiogramPulse.fromValue = 1.0
        cardiogramPulse.toValue = 1.12
        cardiogramPulse.autoreverses = true
        cardiogramPulse.repeatCount = 1
        cardiogramPulse.initialVelocity = 0.5
        cardiogramPulse.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [cardiogramPulse]
        cardiogramOutlet.layer.add(animationGroup, forKey: "pulse")
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
//            self.tipsLabel.text = self.sexualTips[Int(arc4random_uniform(UInt32(self.sexualTips.count)))]
//        }
        countdownTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    func countdownTimer() {
        timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(WaitingForPartnerViewController.countdownTick), userInfo: nil, repeats: true)
    }
    
    @objc func countdownTick() {
        countdown -= 1
        
        UIView.animate(withDuration: 3) {
            self.tipsLabel.alpha = 0
            self.tipsLabel.text = self.sexualTips[self.countdown]
            self.tipsLabel.alpha = 0.6
        }
        
        if countdown == 0 {
            countdown = sexualTips.count
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var cardiogramOutlet: UIImageView!
    @IBOutlet weak var tipsLabel: UILabel!
    var sexualTips: [String] = ["Touching your partner increases intimacy.", "Think about what surrounds and try to create an atmosphere for intimacy."]
    var timer: Timer? = nil
    var countdown = 2 //sexualTips.count
}
