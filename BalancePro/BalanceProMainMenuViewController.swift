//
//  BalanceProMainMenuViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 6/26/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class BalanceProMainMenuViewController: UIViewController {

    @IBOutlet weak var singlePlaneVectorBalanceButton: UIButton!
    @IBOutlet weak var multiPlaneVectorBalance: UIButton!
    @IBOutlet weak var vectorBalanceView: UIView!
    
    @IBOutlet weak var sixMeasureBalanceButton: UIButton!
    @IBOutlet weak var twoMeasureBalanceButton: UIButton!
    @IBOutlet weak var nonVectorBalanceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //SetRoundedButton(forButton: singlePlaneVectorBalanceButton)
        singlePlaneVectorBalanceButton.roundCorners([.topLeft, .bottomLeft], radius: 40)
        multiPlaneVectorBalance.roundCorners([.topLeft, .bottomLeft], radius: 40)
        
        sixMeasureBalanceButton.roundCorners([.topLeft, .bottomLeft], radius: 40)
        twoMeasureBalanceButton.roundCorners([.topLeft, .bottomLeft], radius: 40)
        
        nonVectorBalanceView.roundCorners([.topLeft, .bottomLeft], radius: 40)
        vectorBalanceView.roundCorners([.topLeft, .bottomLeft], radius: 40)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
