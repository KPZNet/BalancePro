//
//  FinalRunViewController.swift
//  BalancePro
//
//  Created by Kenneth Ceglia on 4/29/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import UIKit

class FinalRunViewController: UIViewController {

    
    @IBOutlet weak var balanceView: BalancePlaneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        balanceView.layer.cornerRadius = 10.0
        balanceView.layer.masksToBounds = true
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
