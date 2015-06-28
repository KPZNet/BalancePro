//
//  BalanceReportViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 6/27/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class BalanceReportViewController: UIViewController {

    @IBOutlet weak var reportView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        SetRoundedViewBox(forView: reportView)
        
        var balResults = GetAppDelegate().singlePlaneBalance
        
        var report:String = String("")
        report = "Initial Unbalanced Vector = " + balResults.initialVector!.string() + "\n"
        report += "Influence Vector = " + balResults.influenceVector!.string() + "\n"
        report += "Trial Weight  = " + balResults.influenceBalanceWeight!.string() + "\n"
        report += "Balance Weight  = " + balResults.balanceWeight!.string() + "\n"
        report += "\n"
        report += "Resulting Vector  = " + balResults.finalVector!.string() + "\n"
        
        reportView.text = report
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
