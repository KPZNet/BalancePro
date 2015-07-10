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


class InfluenceRunViewController: UIViewController {
    
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weightMeasureLabel: UILabel!
    
    @IBOutlet weak var weightPlacementLabel: UILabel!
    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balaneWeightMeasureFinal: UITextField!
    @IBOutlet weak var balanceWeightPlacementFinal: UITextField!
    
    @IBOutlet weak var addVectorButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var balancePlane: BalancePlaneViewInfluenceVector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        //SetRoundedButton(forButton: addVectorButton)
        addVectorButton.roundCorners(.TopLeft | .BottomLeft, radius: 20)
        calculateButton.roundCorners(.TopLeft | .BottomLeft, radius: 20)
        
        weightLabel.hidden = true
        weightMeasureLabel.hidden = true
        weightPlacementLabel.hidden = true
        balaneWeightMeasureFinal.hidden = true
        balanceWeightPlacementFinal.hidden = true
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
        
        weightLabel.hidden = false
        weightMeasureLabel.hidden = false
        weightPlacementLabel.hidden = false
        balaneWeightMeasureFinal.hidden = false
        balanceWeightPlacementFinal.hidden = false
        
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }
    
    @IBAction func AddVector(sender: AnyObject) {
        
        var influenceVectAmp = (vectorAmplitude.text as NSString).floatValue
        var influenceVectPhase = (vectorPhase.text as NSString).floatValue
        
        var trialVect = Vector(fromAmp: influenceVectAmp, fromPhaseInDegrees: influenceVectPhase, withRunType: BalanceRunType.trial)

        GetAppDelegate().singlePlaneBalance.trialVector = trialVect
        
        var balanceWeight = CalcBalanceWeight()
        
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }
    
}

