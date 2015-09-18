//
//  TrialWeightViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 7/8/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class BalancePlaneViewTrialWeight : BalancePlaneView
{
    
    override func drawRect(rect: CGRect)
    {
        
        SetupScales(MaxVib: GetAppDelegate().singlePlaneBalance.GetVectorScale() )
        
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect,vectorColor:initVect.color)
        }
        
        if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
        {
            DrawWeight(wP)
        }
        
    }
    
}

class TrialWeightViewController: UIViewController {

    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
    @IBOutlet weak var addTrialWeightButton: UIButton!
    
    @IBOutlet weak var balancePlane: BalancePlaneViewInfluenceVector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        //SetRoundedButton(forButton: addVectorButton)
        addTrialWeightButton.roundCorners([.TopLeft, .BottomLeft], radius: 20)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddTrialWeight(sender: AnyObject) {
        
        var influenceBalanceWeight = (balaneWeightMeasure.text as NSString).floatValue
        var influenceBalancePlacement = (balanceWeightPlacement.text as NSString).floatValue
        
        GetAppDelegate().singlePlaneBalance.influenceBalanceWeight = BalanceWeight(fromWeight: influenceBalanceWeight, fromLocation: influenceBalancePlacement)
        
        balancePlane.clearsContextBeforeDrawing = true;
        balancePlane.setNeedsDisplay()
    }

}




