//
//  CalculationResultsViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 7/22/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit






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
            
        balancePlane.setNeedsDisplay()
    }
    

    
}


