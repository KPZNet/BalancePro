//
//  InfluenceRunViewController.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit



class BalancePlaneViewInfluenceVector : BalancePlaneView
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
                }
            }
        }
        
        if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
        {
            DrawWeight(wP)
        }
        
    }
    
}


class InfluenceRunViewController: UIViewController {
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var addVectorButton: UIButton!
    
    @IBOutlet weak var balancePlane: BalancePlaneViewInfluenceVector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        //SetRoundedButton(forButton: addVectorButton)
        addVectorButton.roundCorners(.TopLeft | .BottomLeft, radius: 20)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CalculateBalanceWeight(sender: AnyObject) {
        
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                var inflVect = trialVect - initVect
                inflVect.runType = BalanceRunType.influence
                GetAppDelegate().singlePlaneBalance.influenceVector = inflVect
            }
        }
        
        var balanceWeight = CalcBalanceWeight()
        GetAppDelegate().singlePlaneBalance.balanceWeight = CalcBalanceWeight()
        
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }
    
    @IBAction func AddVector(sender: AnyObject) {
        
        var influenceVectAmp = (vectorAmplitude.text as NSString).floatValue
        var influenceVectPhase = (vectorPhase.text as NSString).floatValue
        
        var trialVect = Vector(fromAmp: influenceVectAmp, fromPhaseInDegrees: influenceVectPhase, withRunType: BalanceRunType.trial)

        GetAppDelegate().singlePlaneBalance.trialVector = trialVect

        
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }
    
}

