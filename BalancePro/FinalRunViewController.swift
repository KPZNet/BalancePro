//
//  FinalRunViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 4/29/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit





class FinalRunViewController: UIViewController {

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balaneWeightMeasure: UITextField!
    @IBOutlet weak var balanceWeightPlacement: UITextField!
    
    @IBOutlet weak var balancePlane: SinglePlaneVectorBalanceView!
    
    @IBOutlet weak var addVectorButton: UIButton!
    @IBOutlet weak var saveBalanceRunButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
        
        //SetRoundedButton(forButton: addVectorButton)
        //SetRoundedButton(forButton: saveBalanceRunButton)
        
        addVectorButton.roundCorners([.topLeft, .bottomLeft], radius: 20)
        saveBalanceRunButton.roundCorners([.topLeft, .bottomLeft], radius: 20)
        
    }
    
    override func viewWillDisappear(_ _animated: Bool){
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        balancePlane.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddVector(_ sender: AnyObject) {

        let vectAmp = vectorAmplitude.text?.ToFloat()
        let vectPhase = vectorPhase.text?.ToFloat()
        
        let finalVect = Vector(fromAmp: vectAmp!, fromPhaseInDegrees: vectPhase!, withRunType: BalanceRunType.final)
        
        GetAppDelegate().singlePlaneBalance.finalVector = finalVect

        balancePlane.setNeedsDisplay()

    }


}
