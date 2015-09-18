//
//  CalculationResultsViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 7/22/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit



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
            drawBVector(initVect, vectorColor: initVect.color)
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                drawBVector(trialVect, vectorColor: trialVect.color)
                if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
                {
                    drawBVector(inflVect, vectorColor: inflVect.color)
                    
                    let TO = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                    drawBVector(TO, vectorColor: TO.color)
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
                let inflVect = trialVect - initVect
                inflVect.runType = BalanceRunType.influence
                GetAppDelegate().singlePlaneBalance.influenceVector = inflVect
            }
        }
        
        let balanceWeight = CalcBalanceWeight()
        GetAppDelegate().singlePlaneBalance.balanceWeight = balanceWeight
        
        balaneWeightMeasureFinal.text = balanceWeight.weight.string(2)
        balanceWeightPlacementFinal.text = balanceWeight.location.string(0)
            
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }
    

    
}


