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
        
        SetupScales(MaxVib: GetAppDelegate().singlePlaneBalance.GetVectorScale() )
        
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect)
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                drawBVector(trialVect)
                if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
                {
                    drawBVector(inflVect)
                    
                    var TO = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                    drawBVector(TO)
                    
                    if let finalVect = GetAppDelegate().singlePlaneBalance.finalVector
                    {
                        drawBVector(finalVect)
                    }
                }
            }
        }
        
        if let balanceWeight = GetAppDelegate().singlePlaneBalance.balanceWeight
        {
            DrawWeight(balanceWeight, color:UIColor(red: (0/255.0), green: (255/255.0), blue: (0/255.0), alpha: 0.5))
        }
        
    }
    
}


class FinalRunViewController: UIViewController {

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
    @IBOutlet weak var balancePlane: BalancePlaneView!
    
    @IBOutlet weak var addVectorButton: UIButton!
    @IBOutlet weak var saveBalanceRunButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        SetRoundedButton(forButton: addVectorButton)
        SetRoundedButton(forButton: saveBalanceRunButton)
        
        if let wP = GetAppDelegate().singlePlaneBalance.balanceWeight
        {
            balanceWeightPlacement.text = wP.location.string(2)
            balaneWeightMeasure.text = wP.weight.string(2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddVector(sender: AnyObject) {
        
        var vectAmp = (vectorAmplitude.text as NSString).floatValue
        var vectPhase = (vectorPhase.text as NSString).floatValue
        
        var finalVect = Vector(fromAmp: vectAmp, fromPhaseInDegrees: vectPhase, withRunType: BalanceRunType.final)
        
        GetAppDelegate().singlePlaneBalance.finalVector = finalVect

        balancePlane.setNeedsDisplay()

    }


}
