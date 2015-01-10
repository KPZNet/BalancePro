//
//  RotorPlaneView.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit

import UIFont

class Vector
{
    var amp : Float
    var phase : Float
    
    var xOrigin : Float
    var yOrigin : Float
    var xEnd : Float
    var yEnd : Float
    
    var name : String
    
    
    init()
    {
        amp = 0.0
        phase = 0
        
        xOrigin = 0.0
        yOrigin = 0.0
        
        xEnd = 0.0
        yEnd = 0.0
        
        name = "vec"
    }
    init(fromAmp _amp : Float, fromPhase _phase : Float)
    {
        name = "vec"
        amp = _amp
        phase = _phase
        
        xOrigin = 0.0
        yOrigin = 0.0
        
        
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radians : Float = 0.0
        radians = DegToRadConversion * Float(phase)
        
        xEnd = Float(  amp * cos( radians ))
        yEnd = Float(  amp * sin( radians ))

    }
    init(xOrigin _xOrigin:Float, yOrigin _yOrigin:Float, xEnd _xEnd:Float, yEnd _yEnd:Float)
    {
        name = "vec"
        amp = 0.0
        phase = 0
        
        xOrigin = _xOrigin
        yOrigin = _yOrigin
        
        xEnd = _xEnd
        yEnd = _yEnd
        
        var tempX :Float = _xEnd - _xOrigin
        var tempY :Float = _yEnd - _yOrigin
        
        var radians = atan2( tempY , tempX )
        
        let RadToDegreesConversion : Float = Float(180) / Float(M_PI)
        phase = RadToDegreesConversion * Float(radians)
        
        amp = sqrt( (tempX * tempX) + (tempY * tempY) )
        
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
    
    func GetRadians(deg : Float) -> Float
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
        
        var radians = GetRadians( Float(weight.location) )
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
    
    func GetArrowEnds( vector : Vector ) -> (xA:Float, yA:Float, xB:Float, yB:Float)
    {
        let arrowAngle : Float = 160
        let arrowLength : Float = 12
        
        var radiansA : Float = 0.0
        var radiansB : Float = 0.0
        
        var degreesA : Float = Float(vector.phase + arrowAngle)
        var degreesB : Float = Float(vector.phase - arrowAngle)
        
        radiansA = GetRadians(degreesA)
        radiansB = GetRadians(degreesB)
        
        var xScaleA : Float = 0.0
        var yScaleA : Float = 0.0
        var xScaleB : Float = 0.0
        var yScaleB : Float = 0.0
        
        xScaleA = cos(radiansA)  * arrowLength
        yScaleA = sin(radiansA)  * arrowLength
        
        xScaleB = cos(radiansB)  * arrowLength
        yScaleB = sin(radiansB)  * arrowLength
        
        
        xScaleA += vector.xEnd
        yScaleA += vector.yEnd
        
        xScaleB += vector.xEnd
        yScaleB += vector.yEnd
        
        return (xScaleA, yScaleA, xScaleB, yScaleB)
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
    
    func drawText(vector : Vector)
    {
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        let text: NSString = "A"
        let font = NSFont(name: "Helvetica Bold", size: 14.0)
        
        let textRect: NSRect = NSMakeRect(5, 3, 125, 18)
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.LeftTextAlignment
        let textColor = NSColor(calibratedRed: 0.147, green: 0.222, blue: 0.162, alpha: 1.0)
        
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: textStyle
        ]
        
        text.drawInRect(NSOffsetRect(textRect, 0, 1), withAttributes: textFontAttributes)
    }
    func drawVector(vector : Vector)
    {
        let strokeWidth = 1.0
        // Get the context

        
        let context = UIGraphicsGetCurrentContext()
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))

        CGContextMoveToPoint(context, CGFloat(vector.xOrigin), CGFloat(vector.yOrigin) )
        CGContextAddLineToPoint(context, CGFloat(vector.xEnd), CGFloat(vector.yEnd))
        CGContextStrokePath(context)
        
        
        var xScaleA : Float = 0.0
        var yScaleA : Float = 0.0
        var xScaleB : Float = 0.0
        var yScaleB : Float = 0.0
        (xScaleA, yScaleA, xScaleB, yScaleB) = GetArrowEnds(vector)
        
        CGContextMoveToPoint(context, CGFloat(vector.xEnd), CGFloat(vector.yEnd))
        CGContextAddLineToPoint(context, CGFloat(xScaleA), CGFloat(yScaleA))
        CGContextStrokePath(context)
        
        CGContextMoveToPoint(context, CGFloat(vector.xEnd), CGFloat(vector.yEnd))
        CGContextAddLineToPoint(context, CGFloat(xScaleB), CGFloat(yScaleB))
        CGContextStrokePath(context)
        
    }

    
    override func drawRect(rect: CGRect)
    {
        AdjustToCenterCartesian()
        
        DrawRotor()
        
        var weight : BalanceWeight = BalanceWeight(fromWeight : 5.0 , fromLocation : 44)
        DrawWeight(weight)
    
        
        var vec = Vector(fromAmp: 120, fromPhase: 340)
        drawVector(vec)
        
        var vec2 = Vector(fromAmp: 130, fromPhase: 75)
        drawVector(vec2)
        
        var vec3 = Vector(xOrigin: vec.xEnd, yOrigin: vec.yEnd, xEnd: vec2.xEnd, yEnd: vec2.yEnd)
        drawVector(vec3)
    
        
    }
    
}
