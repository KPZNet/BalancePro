//
//  FinalRunViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 4/29/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class BalancePlaneViewFinalVector : BalancePlaneView
{
    override func drawRect(rect: CGRect)
    {
        
        SetupScales(MaxVib: 10.0)
        
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let vect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(vect)
        }
        
    }
    
}

class FinalRunViewController: UIViewController {

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
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
        
        var balanceMeasureString:NSString = balaneWeightMeasure.text
        var balanceWM = balanceMeasureString.floatValue
        
        var balancePlacementString:NSString = balanceWeightPlacement.text
        var balanceWP = balancePlacementString.floatValue
        
        var vec0 = Vector(fromAmp: amp, fromPhaseInDegrees: phase, withRunType: BalanceRunType.initial)
        var bW = BalanceWeight(fromWeight: balanceWM, fromLocation: balanceWP)
        
        GetAppDelegate().singlePlaneBalance.finalVector = vec0
        GetAppDelegate().singlePlaneBalance.balanceWeight = bW
        
        balancePlane.setNeedsDisplay()

    }


}
