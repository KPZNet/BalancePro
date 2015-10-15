//
//  RunConfigurationViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 5/4/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class RunConfigurationViewController: UIViewController {

    @IBOutlet weak var BalancePlane: SinglePlaneVectorBalanceViewConfiguration!
    @IBOutlet weak var shaftRotation: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(BalancePlane.shaftRotation == ShaftRotationType.cw){
            shaftRotation.selectedSegmentIndex = 0
        }
        else{
            shaftRotation.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnRotationDirectionChange(sender: AnyObject) {
        if(shaftRotation.selectedSegmentIndex == 0){
            BalancePlane.shaftRotation = ShaftRotationType.cw
        }
        else{
            BalancePlane.shaftRotation = ShaftRotationType.ccw
        }
        BalancePlane.setNeedsDisplay()
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
