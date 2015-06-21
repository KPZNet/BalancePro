//
//  InfluenceRunViewController.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit

class InfluenceRunViewController: UIViewController {

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
    @IBOutlet weak var balancePlane: BalancePlaneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        var balanceMeasureString:NSString = balaneWeightMeasure.text
        var balanceWM = balanceMeasureString.floatValue
        
        var balancePlacementString:NSString = balanceWeightPlacement.text
        var balanceWP = balancePlacementString.floatValue
        
        var vec0 = Vector(fromAmp: amp, fromPhaseInDegrees: phase, withRunType: BalanceRunType.trial)
        var bW = BalanceWeight(fromWeight: balanceWM, fromLocation: balanceWP)
        
        GetAppDelegate().singlePlaneBalance.influenceVector = vec0
        GetAppDelegate().singlePlaneBalance.influenceBalanceWeight = bW

        balancePlane.setNeedsDisplay()
    }

}

