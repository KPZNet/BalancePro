//
//  CalculationResultsViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 7/22/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
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

class BalancePlaneViewCalculationResults : BalancePlaneView
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
        if let wPF = GetAppDelegate().singlePlaneBalance.balanceWeight
        {
            DrawWeight(wPF, color:UIColor(red: (0/255.0), green: (255/255.0), blue: (0/255.0), alpha: 0.5))
            
        }
        
    }
    
}


class CalculationResultsViewController: UIViewController {
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weightMeasureLabel: UILabel!
    
    @IBOutlet weak var weightPlacementLabel: UILabel!
    
    
    @IBOutlet weak var balaneWeightMeasureFinal: UITextField!
    @IBOutlet weak var balanceWeightPlacementFinal: UITextField!
    
    @IBOutlet weak var balancePlane: BalancePlaneViewCalculationResults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        CalculateBalanceWeight()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CalculateBalanceWeight() {
        
        
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
        GetAppDelegate().singlePlaneBalance.balanceWeight = balanceWeight
        
        balaneWeightMeasureFinal.text = balanceWeight.weight.string(2)
        balanceWeightPlacementFinal.text = balanceWeight.location.string(0)
            
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }
    

    
}


