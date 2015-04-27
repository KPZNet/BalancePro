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
    var phase : Float
    
    var xOrigin : Float
    var yOrigin : Float
    var xEnd : Float
    var yEnd : Float
    
    var name : String
    var color : UIColor?

    
    
    
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
    
    var pCartesianTrans : CGAffineTransform = CGAffineTransformIdentity
    var vibScale: Float = Float(10.0)
    var vibScaleLineWidth : Float = Float(0.1)
    var rotorRadius : Float = 1.0
    var vectorStrokeWidth : Float = 1.0
    var vectorArrowLength : Float = 1.0
    
    //    override init(frame aRect: CGRect)
    //    {
    //
    //        super.init(frame:aRect)
    //        pTrans = GetTransform()
    //
    //    }
    //
    //    required init(coder aDecoder: NSCoder)
    //    {
    //        super.init(coder:aDecoder)
    //
    //    }
    
    func InitalizeCartesianTransform()
    {
        pCartesianTrans = GetCartisianTransform()
    }
    func PushToCartesianTransform()
    {
        CGContextSaveGState(UIGraphicsGetCurrentContext())
        
        let context = UIGraphicsGetCurrentContext()
        CGContextConcatCTM(context, pCartesianTrans);
    }
    func PopToDefaultTransform()
    {
        CGContextRestoreGState(UIGraphicsGetCurrentContext())
    }
    func GetCartisianTransform() -> CGAffineTransform
    {
        
        let context = UIGraphicsGetCurrentContext()
        var pTempCartesianTransform : CGAffineTransform = CGAffineTransformIdentity
        
        pTempCartesianTransform = CGAffineTransformTranslate(pTempCartesianTransform, (self.frame.size.width / 2), (self.frame.size.height / 2));
        
        let xScale =  (self.frame.size.width / 2) / CGFloat(vibScale)
        let yScale = -1.0 * ( (self.frame.size.height / 2) / CGFloat(vibScale) )
        
        pTempCartesianTransform = CGAffineTransformScale(pTempCartesianTransform, CGFloat(xScale), CGFloat(yScale));
        
        return pTempCartesianTransform
    }
    
    func GetRotatedTextTransform(At _point:CGPoint, Rotate _rotate:Float) -> CGAffineTransform
    {
        let context = UIGraphicsGetCurrentContext()
        var pTempTransform : CGAffineTransform = CGAffineTransformIdentity
        
        pTempTransform = CGAffineTransformTranslate(pTempTransform, _point.x, _point.y)
        pTempTransform = CGAffineTransformRotate(pTempTransform, CGFloat(_rotate) * -1.0 );
        
        return pTempTransform
    }
    
    func PushToTextTransform(At _point:CGPoint, Rotate _rotate:Float)
    {
        CGContextSaveGState(UIGraphicsGetCurrentContext())
        
        let context = UIGraphicsGetCurrentContext()
        CGContextConcatCTM(context, GetRotatedTextTransform(At:_point, Rotate:_rotate));
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
        PushToCartesianTransform()
        
        var x : Float
        var y : Float
        
        let margin = 0
        
        // Drawing code
        // Set the radius
        let weightSlotRadius = rotorRadius * 0.1
        let strokeWidth = vibScaleLineWidth
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        let weightSlotCenter = Float( rotorRadius ) - Float(weightSlotRadius)
        
        var radians = GetRadians( Float(weight.location) )
        x = weightSlotCenter * cos( radians )
        y = weightSlotCenter * sin( radians )
        
        
        // Find the middle of the circle
        let center = CGPointMake( CGFloat(x), CGFloat(y) )
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(weightSlotRadius), CGFloat(0), CGFloat(2 * M_PI), 1)
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        PopToDefaultTransform()
    }
    
    func DrawRotorCenterNob()
    {
        PushToCartesianTransform()
        

        var startAngle: Float = Float(2.0 * M_PI)
        var endAngle: Float = 0.0
                
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(0 , 0)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(rotorRadius * 0.01), CGFloat(0), CGFloat(2.0 * M_PI), 1)
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Set the stroke color
        //CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        PopToDefaultTransform()
        
    }

    func DrawRotor()
    {
        PushToCartesianTransform()
        

        var startAngle: Float = Float(2.0 * M_PI)
        var endAngle: Float = 0.0
                
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(0 , 0)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(rotorRadius), CGFloat(0), CGFloat(2.0 * M_PI), 1)
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        PopToDefaultTransform()

        DrawRotorCenterNob()
        
    }
    
    func DrawVectorName(vector:Vector)
    {
        
        var midPoint : CGPoint = CGPoint(x:0, y:0)
        
        midPoint.x = CGFloat((vector.xOrigin + vector.xEnd) / Float(2.0))
        midPoint.y = CGFloat((vector.yOrigin + vector.yEnd) / Float(2.0))
        
        DrawTextAt(Text: vector.name, At: midPoint, Rotate: vector.phase, Size: 12)
        
    }
    
       
    func GetArrowEnds( vector : Vector ) -> (xA:Float, yA:Float, xB:Float, yB:Float)
    {
        let arrowAngle : Float = 160
        let arrowLength : Float = vectorArrowLength
        
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
    
    func drawVector(vector : Vector)
    {
        PushToCartesianTransform()
        
        // Get the context
        
        let context = UIGraphicsGetCurrentContext()
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vectorStrokeWidth))
        
        CGContextMoveToPoint(context, CGFloat(vector.xOrigin), CGFloat(vector.yOrigin) )
        CGContextAddLineToPoint(context, CGFloat(vector.xEnd), CGFloat(vector.yEnd))
        CGContextStrokePath(context)
        
        
        var xScaleA : Float = 0.0
        var yScaleA : Float = 0.0
        var xScaleB : Float = 0.0
        var yScaleB : Float = 0.0
        var xMidScale : Float = 0.0
        var yMidScale : Float = 0.0
        
        (xScaleA, yScaleA, xScaleB, yScaleB) = GetArrowEnds(vector)
        xMidScale = vector.xEnd
        yMidScale = vector.yEnd
        
        
        CGContextMoveToPoint(context, CGFloat(xScaleA), CGFloat(yScaleA))
        CGContextAddLineToPoint(context, CGFloat(xMidScale), CGFloat(yMidScale))
        CGContextAddLineToPoint(context, CGFloat(xScaleB), CGFloat(yScaleB))
        CGContextStrokePath(context)
        
        PopToDefaultTransform()
        
        DrawVectorName(vector)
        
    }
    
    func DrawTextAt(Text _text:String, At _point:CGPoint, Rotate _rotate:Float, Size _size : Int)
    {
        let fontName = "Helvetica"
        let textFont:UIFont = UIFont(name: fontName, size: CGFloat(_size))!
        
        var  textHeight:Float = Float(textFont.lineHeight) / Float(2.0)
        
        let adjustPoint:CGPoint = CGPoint(  x:_point.x, y: _point.y + CGFloat(textHeight) )
        
        var pPoint:CGPoint = CGPointApplyAffineTransform ( adjustPoint, pCartesianTrans );
        
        PushToTextTransform(At: pPoint, Rotate: GetRadians(_rotate) )
        
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        var tattribs = [NSFontAttributeName: textFont, NSParagraphStyleAttributeName: textStyle]
        _text.drawAtPoint(CGPointMake(0,0), withAttributes: tattribs)
        
        PopToDefaultTransform()
        
    }
    
    
    func DrawDegreeLabel(At _point:CGPoint, Ratio _ratio:CGPoint, Degree _degree:Float)
    {
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        let centerExtension:CGFloat = CGFloat( (vibScale * 0.1) / 2.0)
        let xExtension:CGFloat = centerExtension * _ratio.x
        let yExtension:CGFloat = centerExtension * _ratio.y
        
        let sPoint:CGPoint = CGPoint(  x:_point.x + xExtension, y: _point.y + yExtension)
        let sRect:CGRect = CGRectMake(0, 0, 20, 10)
        var aPoint:CGPoint = CGPointApplyAffineTransform ( sPoint, pCartesianTrans );
        
        let degTextInt:NSNumber = Int(_degree)
        let degText:String = degTextInt.stringValue

        var label = UILabel(frame: sRect)
        label.center = aPoint
        label.font = textFont
        label.textAlignment = NSTextAlignment.Center
        label.text = degText
        //label.backgroundColor = UIColor.lightTextColor()
        //label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        addSubview(label)

    }
    
    
    func DrawRotorDegreeTics()
    {
        
        let context = UIGraphicsGetCurrentContext()

        let lineLength = ( (vibScale * 0.1) / 3.0 )
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vibScaleLineWidth))
        
        PushToCartesianTransform()
        for var index = 0; index < 360; index+=15
        {
            
            var xStart : Float = (rotorRadius - lineLength) * cos( GetRadians( Float(index) ) )
            var yStart : Float = (rotorRadius - lineLength) * sin( GetRadians( Float(index) ) )
            var xEnd   : Float = (rotorRadius) * cos( GetRadians( Float(index) ) )
            var yEnd   : Float = (rotorRadius) * sin( GetRadians( Float(index) ) )
            
            CGContextMoveToPoint(context, CGFloat(xStart), CGFloat(yStart))
            CGContextAddLineToPoint(context, CGFloat(xEnd), CGFloat(yEnd))
            CGContextStrokePath(context)
            
        }
        PopToDefaultTransform()
        
    }
    
    func DrawRotorDegreeTicLabels()
    {
      
        for var index = 0; index < 360; index+=45
        {
            
            var xEnd2   : Float = cos( GetRadians( Float(index) ) )
            var yEnd2   : Float = sin( GetRadians( Float(index) ) )
            var ratioPoint:CGPoint = CGPoint(x:CGFloat(xEnd2), y:CGFloat(yEnd2))
            var textPoint:CGPoint = CGPoint(x:CGFloat(xEnd2 * rotorRadius), y:CGFloat(yEnd2 * rotorRadius))
            DrawDegreeLabel(At: textPoint, Ratio:ratioPoint, Degree:Float(index))
            
        }

    }
    
    func Setup()
    {
        vibScale = Float(10.0)
        vibScaleLineWidth = (vibScale * 0.01)
        vectorStrokeWidth = vibScale * 0.02
        vectorArrowLength = vibScale * Float(0.06)

        rotorRadius = vibScale * 0.85

        InitalizeCartesianTransform()
        
    }
    
    override func drawRect(rect: CGRect)
    {
        
        Setup()
        
        DrawRotor()
        
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        var weight : BalanceWeight = BalanceWeight(fromWeight : 5.0 , fromLocation : 44)
        DrawWeight(weight)
//        
//        
        var vec = Vector(fromAmp: 5, fromPhase: 340)
        drawVector(vec)
//        
//        var vec2 = Vector(fromAmp: 8, fromPhase: 75)
//        drawVector(vec2)
//        
//        var vec3 = Vector(xOrigin: vec.xEnd, yOrigin: vec.yEnd, xEnd: vec2.xEnd, yEnd: vec2.yEnd)
//        drawVector(vec3)
        
        
    }
    
}
