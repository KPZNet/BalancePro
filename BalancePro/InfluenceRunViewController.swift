//
//  InfluenceRunViewController.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit


func CalcAngleDegreesBetweenVectors(_v1:Vector, _v2:Vector) -> Float
{
    var v1Phase = _v1.phase
    var v2Phase = _v2.phase
    
    var deg = Float(v1Phase - v2Phase)
    if deg < 0.0 { deg += 360 }
    
    return deg
}

func CalcBalanceWeight() -> BalanceWeight
{
    var balWeight:BalanceWeight = BalanceWeight()
    
    if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
    {
        if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
        {
            if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
            {
                var inflVectOrigin = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                
                var initVectNeg = -1*initVect
                
                var influenceVectOrigAmp = inflVectOrigin.amp
                var initVectAmp = initVect.amp
                
                var balanceWeightRatio:Float = wP.weight/influenceVectOrigAmp
                var bW = balanceWeightRatio * initVectAmp
                
                let deg = CalcAngleDegreesBetweenVectors(initVectNeg, inflVectOrigin)
                let wL = (wP.location + deg) % 360
                
                var bWeight:BalanceWeight = BalanceWeight(fromWeight: bW, fromLocation: wL)
                
                balWeight = bWeight
            }
        }
    }
    
    return balWeight
}

class BalancePlaneViewInfluenceVector : BalancePlaneView
{
    override func drawRect(rect: CGRect)
    {
        
        SetupScales(MaxVib: 15.0)
        
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

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
    @IBOutlet weak var balaneWeightMeasureFinal: UITextField!
    @IBOutlet weak var balanceWeightPlacementFinal: UITextField!
    
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
        
        var trialVect = Vector(fromAmp: amp, fromPhaseInDegrees: phase, withRunType: BalanceRunType.trial)
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            var inflVect = trialVect - initVect
            inflVect.runType = BalanceRunType.influence
            GetAppDelegate().singlePlaneBalance.influenceVector = inflVect
        }
        var iBW = BalanceWeight(fromWeight: balanceWM, fromLocation: balanceWP)
        
        GetAppDelegate().singlePlaneBalance.trialVector = trialVect
        GetAppDelegate().singlePlaneBalance.influenceBalanceWeight = iBW
        
        var bW = CalcBalanceWeight()
        GetAppDelegate().singlePlaneBalance.balanceWeight = bW
        
        balanceWeightPlacementFinal.text = bW.location.description
        balaneWeightMeasureFinal.text = bW.weight.description

        balancePlane.setNeedsDisplay()
    }

}

