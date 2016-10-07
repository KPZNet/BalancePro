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
        
        let balResults = GetAppDelegate().singlePlaneBalance
        var report:String = String("")
        
        if let vect = balResults.initialVector
        {
            report = "Initial Unbalanced Vector = " + "\t" + vect.string() + "\n"
        }
        if let vect = balResults.influenceVector
        {
            report += "Influence Vector = " + "\t" + vect.string() + "\n"
        }
        if let weight = balResults.influenceBalanceWeight
        {
            report += "Trial Weight  = " + "\t" + weight.string() + "\n"
        }
        if let weight = balResults.balanceWeight
        {
            report += "Balance Weight  = " + "\t" + weight.string() + "\n"
        }
        report += "\n"
        if let vect = balResults.finalVector
        {
            report += "Resulting Vector  = " + "\t" + vect.string() + "\n"
        }
        
        reportView.text = report
    }
    
    override func viewWillDisappear(_ _animated: Bool){
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        
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
