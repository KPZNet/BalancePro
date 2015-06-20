//
//  FinalRunViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 4/29/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class FinalRunViewController: UIViewController {

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balancePlane: BalancePlaneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddVector(sender: AnyObject) {
        
        var ampString:NSString = vectorAmplitude.text
        var amp = ampString.floatValue
        
        var phaseString:NSString = vectorPhase.text
        var phase = phaseString.floatValue
        
        var vec0 = Vector(fromAmp: amp, fromPhaseInDegrees: phase, withRunType: BalanceRunType.initial)
        balancePlane.AddVector(vec0)
    }


}
