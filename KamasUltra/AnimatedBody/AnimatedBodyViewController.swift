//
//  AnimatedBodyViewController.swift
//  KamasUltra
//
//  Created by Giovanni Ranieri on 13/12/2017.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit
import AudioToolbox

class AnimatedBodyViewController: UIViewController {
    
    var enableSwipe = 1
    var enableTouch = 0
    
    
    
    @objc func funcTap() {
        if enableTouch == 1 {
            UIView.animate(withDuration: 1, animations: {
                self.transparentBodyOutlet.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.transparentBodyOutlet.frame.origin.y = CGFloat(20)
                
                self.bodyVIew.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.bodyVIew.frame.origin.y = CGFloat(20)
                self.bodyPartLabel.frame.origin.y = CGFloat(Double(truncating: self.c) * 625 + 10)
                self.confirmOutlet.alpha = 1.0
            })
            enableSwipe = 1
            enableTouch = 0
        }
        
    }
    
    @IBOutlet weak var transparentBodyOutlet: UIImageView!
    
    @IBOutlet weak var bodyPartLabel: UILabel!

    @IBOutlet weak var bodyVIew: UIView!
    
    @IBOutlet weak var confirmOutlet: UIButton!
    
    var a: NSNumber = 0.00
    var b: NSNumber = 0.45
    var c: NSNumber = 0.50
    var d: NSNumber = 0.55
    var e: NSNumber = 1.00
    
    let gradientColor1 = UIColor(red: 53/255, green: 208/255, blue: 243/255, alpha: 1).cgColor
    let gradientColor2 = UIColor(red: 24/255, green: 129/255, blue: 125/255, alpha: 1).cgColor
    let gradientColor3 = UIColor(red: 255/255, green: 55/255, blue: 55/255, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        let tap = UITapGestureRecognizer(target: self, action: #selector(funcTap))
        self.bodyVIew.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var gradientLayer: CAGradientLayer!
    
    func createGradientLayer() {
        
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bodyVIew.bounds
        
        gradientLayer.colors = [gradientColor1,gradientColor2, gradientColor3,gradientColor2,gradientColor1]
        
        gradientLayer.locations = [a,b,c,d,e]
        gradientLayer.speed = 1000
        bodyVIew.layer.addSublayer(gradientLayer)
        
        //self.view.layer.addSublayer(gradientLayer)
        //self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enableSwipe == 1 {
            for touch in touches {
                let touchLocation = touch.location(in: bodyVIew)
                if touchLocation.x < 190 && touchLocation.x > 0 {
                    if touchLocation.y < 620 && touchLocation.y > 3 {
                        c = touchLocation.y / 625 as NSNumber
                        b = Double(truncating: c) - 0.05 as NSNumber
                        d = Double(truncating: c) + 0.05 as NSNumber
                        gradientLayer.locations = [a,b,c,d,e]
                        
                        bodyPartLabel.frame.origin.y = CGFloat(Double(truncating: c) * 625 + 10)
                    }
                }
                
                if Double(truncating: c) < 0.55 && Double(truncating: c) > 0.45 {
                    bodyPartLabel.text = "dick"
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    
                } else {
                    bodyPartLabel.text = "not dick"
                    
                }
            }
        }
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, animations: {
            self.transparentBodyOutlet.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.transparentBodyOutlet.frame.origin.y = CGFloat(20)
            
            self.bodyVIew.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.bodyVIew.frame.origin.y = CGFloat(20)
            self.bodyPartLabel.frame.origin.y = CGFloat(Double(truncating: self.c) * 425 + 10)
            self.confirmOutlet.alpha = 0.0
        })

        enableSwipe = 0
        enableTouch = 1
        
    }
    
    
    
}
