//
//  InitialRunViewController
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit

class BalancePlaneViewInitialVector : BalancePlaneView
{
    override func drawRect(rect: CGRect)
    {
        
        SetupScales(MaxVib: 10.0)
        
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let vect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(vect)
        }
        
    }
    
}

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
        
        
        var ampString:NSString = vectorAmplitude.text
        var amp = ampString.floatValue
        
        var phaseString:NSString = vectorPhase.text
        var phase = phaseString.floatValue
        
        var vec0 = Vector(fromAmp: amp, fromPhaseInDegrees: phase, withRunType: BalanceRunType.initial)
        GetAppDelegate().singlePlaneBalance.initialVector = vec0
        
        balancePlane.setNeedsDisplay()
        
    }


}

