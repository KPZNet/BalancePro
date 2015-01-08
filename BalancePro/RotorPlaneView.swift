//
//  RotorPlaneView.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit

class Vector
{
    var amp : Float
    var phase : Int
    
    init()
    {
        amp = 0.0
        phase = 0
    }
    init(fromAmp _amp : Float, fromPhase _phase : Int)
    {
        amp = _amp
        phase = _phase
    }
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



class RotorPlaneView: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    func AdjustToCenterCartesian()
    {
        
        let context = UIGraphicsGetCurrentContext()
        var transform = CGAffineTransformIdentity
        
        transform = CGAffineTransformTranslate(transform, (self.frame.size.width / 2), (self.frame.size.height / 2));
        
        let xScale =  1.0
        let yScale = -1.0
        
        transform = CGAffineTransformScale(transform, CGFloat(xScale), CGFloat(yScale));
        
        
        CGContextConcatCTM(context, transform);
    }
    
    func ConvertVectorToXY(vector : Vector) -> (x:Float, y:Float)
    {
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radians : Float = 0.0
        radians = DegToRadConversion * Float(vector.phase)
        var magnitude = vector.amp
        
        var x = Float(  magnitude * cos( radians ))
        var y = Float(  magnitude * sin( radians ))
        
        return (x, y)
    }
    
    func GetRadians(deg : Int) -> Float
    {
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radian : Float = 0.0
        
        radian = DegToRadConversion * Float(deg)
        
        return radian
    }
    
    func DrawWeight( weight : BalanceWeight )
    {
        
        var x : Int
        var y : Int
        
        let weightSlotSize = 10
        let margin = 5
        
        // Drawing code
        // Set the radius
        let strokeWidth = 1.0
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        let weightSlot = Float( (self.frame.size.width/2.0) ) - Float(weightSlotSize) - Float(margin)
        
        var radians = GetRadians(weight.location)
        x = Int(  weightSlot * cos( radians ))
        y = Int(  weightSlot * sin( radians ))
        
        
        // Find the middle of the circle
        let center = CGPointMake( CGFloat(x), CGFloat(y) )
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Draw the arc around the circle
        let radius = CGFloat(10)
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), CGFloat(0), CGFloat(2 * M_PI), 1)
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
    }
    func DrawRotor()
    {
        var startAngle: Float = Float(2 * M_PI)
        var endAngle: Float = 0.0
        
        // Drawing code
        // Set the radius
        let strokeWidth = 1.0
        let radius = CGFloat( (CGFloat(self.frame.size.width) - CGFloat(strokeWidth)) / 2)
        
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(0 , 0)
        
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), CGFloat(0), CGFloat(2 * M_PI), 1)
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)

        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle

    }
    
    func drawVector(vector : Vector)
    {
        let strokeWidth = 1.0
        // Get the context
        var x : Float = 0
        var y : Float = 0
        
        (x, y) =  ConvertVectorToXY(vector)
        
        let context = UIGraphicsGetCurrentContext()
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))

        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, CGFloat(x), CGFloat(y))
        CGContextStrokePath(context)
    }

    
    override func drawRect(rect: CGRect)
    {
        AdjustToCenterCartesian()
        
        DrawRotor()
        
        var weight : BalanceWeight = BalanceWeight(fromWeight : 5.0 , fromLocation : 44)
        DrawWeight(weight)
    
        var vec : Vector = Vector(fromAmp: 50.0, fromPhase: 25)
        drawVector(vec)
        
        vec = Vector(fromAmp: 75, fromPhase: 120)
        drawVector(vec)

        
    }
    
}
