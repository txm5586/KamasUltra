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
    
    var enableSwipe = 1 //if 1 enable the swipe to move the gradient and select the body part
    var enableTouch = 0 //if 1 enable the tap on the body when it's small to return fullscreen
    
    //function of the tap gesture on the body to make it bigger and move it in the center of the screen
    @objc func funcTap() {
        if enableTouch == 1 {
            UIView.animate(withDuration: 1, animations: {
                
                self.transparentBodyOutlet.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.transparentBodyOutlet.frame.origin.y = CGFloat(20)
                
                self.bodyVIew.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.bodyVIew.frame.origin.y = CGFloat(20)
                
                //The label follows the red line
                self.bodyPartLabel.frame.origin.y = CGFloat(Double(truncating: self.c) * 625 + 10)
                
                self.confirmOutlet.alpha = 1.0 //The confirm button appears
                
                self.waveGif.frame.origin.y = CGFloat(667) //Wave goes down
                
                //Buttons disappear below
                self.kiss.frame.origin.y = CGFloat(755)
                self.lick.frame.origin.y = CGFloat(755)
                self.suck.frame.origin.y = CGFloat(755)
                self.touch.frame.origin.y = CGFloat(755)
                self.random.frame.origin.y = CGFloat(755)
            })
            enableSwipe = 1 //Enable the swipe of the red line
            enableTouch = 0 //Disable the touch to make the body bigger again
        }
        
    }
    
    //Outlets of the body, label with the body part selected and confirm button
    @IBOutlet weak var transparentBodyOutlet: UIImageView!
    
    @IBOutlet weak var bodyPartLabel: UILabel!

    @IBOutlet weak var bodyVIew: UIView!
    
    @IBOutlet weak var confirmOutlet: UIButton!
    
    @IBOutlet weak var waveGif: UIImageView!
    
    @IBOutlet weak var kiss: UIButton!
    @IBOutlet weak var lick: UIButton!
    @IBOutlet weak var suck: UIButton!
    @IBOutlet weak var touch: UIButton!
    @IBOutlet weak var random: UIButton!
    
    //Parameters to give a location to the gradient and move it on the body
    var a: NSNumber = 0.00
    var b: NSNumber = 0.45
    var c: NSNumber = 0.50
    var d: NSNumber = 0.55
    var e: NSNumber = 1.00
    
    //Our colors for the gradient
    //Light blue
    let gradientColor1 = UIColor(red: 53/255, green: 208/255, blue: 243/255, alpha: 1).cgColor
    //Dark green
    let gradientColor2 = UIColor(red: 24/255, green: 129/255, blue: 125/255, alpha: 1).cgColor
    //Red
    let gradientColor3 = UIColor(red: 255/255, green: 55/255, blue: 55/255, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createGradientLayer()
       
        //Crate the tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(funcTap))
        self.bodyVIew.addGestureRecognizer(tap) //Add the tap gesture recognizerer to the body
        
        //Assing wave gif
        waveGif.loadGif(name: "gifName")
    }
    
    //Hide the status bar
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
    
    //func called in the viewDidLoad to create the gradient on the body
    func createGradientLayer() {
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = bodyVIew.bounds
        gradientLayer.colors = [gradientColor1,gradientColor2, gradientColor3,gradientColor2,gradientColor1]
        gradientLayer.locations = [a,b,c,d,e]
        gradientLayer.speed = 1000 //made the speed of the gradient bigger to make it follow the tap without delay
        bodyVIew.layer.addSublayer(gradientLayer)
    }
    
    //func called when the user touches the body to move the gradient
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //if the swipe is enabled move the red line of the gradient depending on the y of the user's touch on the body
        if enableSwipe == 1 {
            for touch in touches {
                let touchLocation = touch.location(in: bodyVIew)
                if touchLocation.x < 190 && touchLocation.x > 0 {
                    if touchLocation.y < 620 && touchLocation.y > 3 {
                        c = touchLocation.y / 625 as NSNumber
                        b = Double(truncating: c) - 0.05 as NSNumber
                        d = Double(truncating: c) + 0.05 as NSNumber
                        gradientLayer.locations = [a,b,c,d,e]
                        
                        //made the label follow the red line
                        bodyPartLabel.frame.origin.y = CGFloat(Double(truncating: c) * 625 + 10)
                    }
                }
                
                //give differents body parts to the bodyPartLabel depending on the y of the red part of the gradient
                switch Double(truncating: c) {
                case 0..<0.07 :
                    bodyPartLabel.text = "Head"
                case 0.07..<0.095 :
                    bodyPartLabel.text = "Ears"
                case 0.095..<0.12 :
                    bodyPartLabel.text = "Mouth"
                case 0.12..<0.16 :
                    bodyPartLabel.text = "Neck"
                case 0.16..<0.22 :
                    bodyPartLabel.text = "Shoulders"
                case 0.22..<0.31 :
                    bodyPartLabel.text = "Chest"
                case 0.31..<0.36 :
                    bodyPartLabel.text = "Arms"
                case 0.36..<0.42 :
                    bodyPartLabel.text = "Abdominal"
                case 0.42..<0.52 :
                    bodyPartLabel.text = "Waist"
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate) //Vibration
                case 0.52..<0.59 :
                    bodyPartLabel.text = "Hands"
                case 0.59..<0.71 :
                    bodyPartLabel.text = "Legs"
                case 0.71..<0.75 :
                    bodyPartLabel.text = "Knees"
                case 0.75..<0.95 :
                    bodyPartLabel.text = "Legs"
                case 0.95...1 :
                    bodyPartLabel.text = "Feet"
                default:
                    break
                }
                
            }
        }
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        //Animations to make the body smaller when user clicks the confirm button and move it on the top of the screen
        UIView.animate(withDuration: 1, animations: {
            
            self.transparentBodyOutlet.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.transparentBodyOutlet.frame.origin.y = CGFloat(20)
            
            self.bodyVIew.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.bodyVIew.frame.origin.y = CGFloat(20)
            
            //The label follows the red line
            self.bodyPartLabel.frame.origin.y = CGFloat(Double(truncating: self.c) * 425 + 10)
            
            self.confirmOutlet.alpha = 0.0 //The button disappears
            
            self.waveGif.frame.origin.y = CGFloat(467) //Wave appears from below
            
            //Buttons appear from below
            self.kiss.frame.origin.y = CGFloat(558)
            self.lick.frame.origin.y = CGFloat(558)
            self.suck.frame.origin.y = CGFloat(555)
            self.touch.frame.origin.y = CGFloat(555)
            self.random.frame.origin.y = CGFloat(555)
        })
        
        enableSwipe = 0 //Disable the swipe of the red line
        enableTouch = 1 //Enable the touch to make the body bigger again
        
    }
    
    
    
}
