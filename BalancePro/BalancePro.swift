//
//  BalancePro.swift
//  BalancePro
//
//  Created by KenCeglia on 5/4/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import Foundation
import UIKit

enum RotationDirection {case cw, ccw}
enum BalanceRunType {case initial, influence, final, general}

class Vector
{
    
    var xOrigin : Float = 0.0
    var yOrigin : Float = 0.0
    var xEnd : Float = 0.0
    var yEnd : Float = 0.0
    
    var name : String = "vec"
    var color : UIColor = UIColor.blueColor()
    
    var runType :BalanceRunType = BalanceRunType.general
    
    var amp : Float
        {
        
        get {
            let tempX :Float = xEnd - xOrigin
            let tempY :Float = yEnd - yOrigin
            
            let radians = atan2( tempY , tempX )
            
            let RadToDegreesConversion : Float = Float(180) * Float(M_PI_2)
            let amp = sqrt( (tempX * tempX) + (tempY * tempY) )
            return amp
        }
    }
    var phase : Float
        {
        
        get {
            let tempX :Float = xEnd - xOrigin
            let tempY :Float = yEnd - yOrigin
            
            let radians = atan2( tempY , tempX )
            
            let RadToDegreesConversion : Float = Float(180) * Float(M_PI_2)
            let phase = RadToDegreesConversion * Float(radians)
            return phase
        }
    }
    
    init()
    {
        
    }
    init(fromAmp _amp : Float, fromPhaseInDegrees _phase : Float, withName _name:String = "")
    {
        name = _name
        
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radians : Float = 0.0
        radians = DegToRadConversion * Float(_phase)
        
        xEnd = Float(  _amp * cos( radians ))
        yEnd = Float(  _amp * sin( radians ))
        
    }
    init(xOrigin _xOrigin:Float, yOrigin _yOrigin:Float, xEnd _xEnd:Float, yEnd _yEnd:Float, withName _name:String = "")
    {
        name = _name
        
        xOrigin = _xOrigin
        yOrigin = _yOrigin
        
        xEnd = _xEnd
        yEnd = _yEnd
        
    }
}

func *(left:Float, right:Vector) -> Vector
{
    
    var vecSub = Vector(xOrigin: 0,
        yOrigin: 0,
        xEnd: right.xEnd * left,
        yEnd: right.yEnd * left,
        withName:"vec")
    
    return vecSub
}
func +(left:Vector, right:Vector) -> Vector
{
    
    var vecSub = Vector(xOrigin: right.xOrigin + left.xOrigin,
        yOrigin: right.yOrigin + left.yOrigin,
        xEnd: right.xEnd + left.xEnd,
        yEnd: right.yEnd + left.yEnd,
        withName:"vec")
    
    return vecSub
}
func -(left:Vector, right:Vector) -> Vector
{
    var vecSub = Vector(xOrigin: right.xEnd, yOrigin: right.yEnd, xEnd: left.xEnd, yEnd: left.yEnd, withName:"vec")
    
    return vecSub
}


class BalanceWeight
{
    var weight : Float
    var location : Int
    
    init()
    {
        weight = 0.0
        location = 0
    }
    init(fromWeight _weight : Float, fromLocation _location : Int)
    {
        weight = _weight
        location = _location
    }
}



