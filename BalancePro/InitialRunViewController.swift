//
//  InitialRunViewController
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit

class InitialRunViewController: UIViewController {

    
    @IBOutlet weak var vectorAmplitude: UITextField!
    @IBOutlet weak var vectorPhase: UITextField!
    
    @IBOutlet weak var balancePlane: BalancePlaneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        balancePlane.layer.cornerRadius = 10.0
        balancePlane.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func AddVector(sender: AnyObject) {
        
//        var vec1 = Vector(fromAmp: 9, fromPhaseInDegrees: 9, withRunType: BalanceRunType.initial)
//        balancePlane.AddVector(vec1)
//        
//        var vec2 = Vector(fromAmp: 9, fromPhaseInDegrees: 120, withRunType: BalanceRunType.influence)
//        balancePlane.AddVector(vec2)
//        
//        var vec3 = Vector(fromAmp: 7.5, fromPhaseInDegrees: 270)
//        balancePlane.AddVector(vec3)
        
        var ampString:NSString = vectorAmplitude.text
        var amp = ampString.floatValue
        
        var phaseString:NSString = vectorPhase.text
        var phase = phaseString.floatValue
        
        var vec0 = Vector(fromAmp: amp, fromPhaseInDegrees: phase, withRunType: BalanceRunType.initial)
        balancePlane.AddVector(vec0)
        
    }


}

