//
//  MoodViewController.swift
//  KamasUltra
//
//  Created by Miky Pane on 18/12/17.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {
    
    //Parameters to give a location to the gradient and move it on the body
    var a: NSNumber = 0.00
    var b: NSNumber = 0.45
    var c: NSNumber = 0.50
    var d: NSNumber = 0.55
    var e: NSNumber = 1.00
    
    //Our colors for the gradient
    //Light blue
    var gradientColor1 = UIColor(red: 53/255, green: 208/255, blue: 243/255, alpha: 1).cgColor
    //Dark green
    var gradientColor2 = UIColor(red: 24/255, green: 129/255, blue: 125/255, alpha: 1).cgColor
    //Red
    var gradientColor3 = UIColor(red: 255/255, green: 55/255, blue: 55/255, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createGradientLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    var gradientLayer: CAGradientLayer!
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [gradientColor1,gradientColor2,gradientColor2,gradientColor1]
        gradientLayer.locations = [a,b,d,e]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    var gradientLayer1: CAGradientLayer!
    func replaceGradientLayer() {
        gradientLayer1 = CAGradientLayer()
        gradientLayer1.frame = view.bounds
        gradientLayer1.colors = [gradientColor1,gradientColor2,gradientColor2,gradientColor1]
        gradientLayer1.locations = [a,b,d,e]
        view.layer.replaceSublayer(gradientLayer, with: gradientLayer1)
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        gradientColor1 = UIColor(red: 255/255, green: 208/255, blue: 243/255, alpha: 1).cgColor
        gradientColor2 = UIColor(red: 24/255, green: 255/255, blue: 125/255, alpha: 1).cgColor
        replaceGradientLayer()
        gradientLayer = gradientLayer1
    }
    
    @IBAction func unwindSegue2(_ sender: UIStoryboardSegue) {
        gradientColor1 = UIColor(red: 53/255, green: 208/255, blue: 243/255, alpha: 1).cgColor
        gradientColor2 = UIColor(red: 24/255, green: 129/255, blue: 125/255, alpha: 1).cgColor
        replaceGradientLayer()
        gradientLayer = gradientLayer1
    }
}
