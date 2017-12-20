//
//  TestWaveViewController.swift
//  KamasUltra
//
//  Created by Giovanni Ranieri on 18/12/2017.
//  Copyright © 2017 Tassio Marques. All rights reserved.
//

import UIKit

class TestWaveViewController: UIViewController {
    @IBOutlet weak var wave2Outlet: UIImageView!
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var waveOutlet: UIImageView!
    
    var a: NSNumber = 0.00
    var b: NSNumber = 0.45
    var c: NSNumber = 0.50
    var d: NSNumber = 0.55
    var e: NSNumber = 1.00
    
    let gradientColor1 = UIColor(red: 53/255, green: 208/255, blue: 243/255, alpha: 1).cgColor
    //Dark green
    let gradientColor2 = UIColor(red: 24/255, green: 129/255, blue: 125/255, alpha: 1).cgColor
    //Red
    let gradientColor3 = UIColor(red: 255/255, green: 55/255, blue: 55/255, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        waveOutlet.image = #imageLiteral(resourceName: "newWave")
        wave2Outlet.image = #imageLiteral(resourceName: "newWave")
       wave2Outlet.image = wave2Outlet.image!.withRenderingMode(UIImageRenderingMode.automatic)
        wave2Outlet.backgroundColor = UIColor.clear
        //wave2Outlet.tintColor = UIColor.clear
    

        createGradientLayer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var gradientLayer: CAGradientLayer!
    
    //func called in the viewDidLoad to create the gradient on the body
    func createGradientLayer() {
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [gradientColor1,gradientColor2, gradientColor3,gradientColor2,gradientColor1]
        gradientLayer.locations = [a,b,c,d,e]
//        gradientLayer.speed = 1000 //made the speed of the gradient bigger to make it follow the tap without delay
        
        gradientView.layer.addSublayer(gradientLayer)
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
