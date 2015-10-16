//
//  TrialWeightViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 7/8/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit



class TrialWeightViewController: UIViewController {

    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
    @IBOutlet weak var addTrialWeightButton: UIButton!
    
    @IBOutlet weak var balancePlane: SinglePlaneVectorBalanceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        //SetRoundedButton(forButton: addVectorButton)
        addTrialWeightButton.roundCorners([.TopLeft, .BottomLeft], radius: 20)
    }
    
    override func viewWillDisappear(_animated: Bool){
        
    }
    
    override func viewWillAppear(animated: Bool){
        
        balancePlane.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddTrialWeight(sender: AnyObject) {
        
        let influenceBalanceWeight = balaneWeightMeasure.text?.ToFloat()
        let influenceBalancePlacement = balanceWeightPlacement.text?.ToFloat()
        
        GetAppDelegate().singlePlaneBalance.influenceBalanceWeight = BalanceWeight(fromWeight: influenceBalanceWeight!, fromLocation: influenceBalancePlacement!)
        
        balancePlane.setNeedsDisplay()
    }

}




