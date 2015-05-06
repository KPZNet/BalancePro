//
//  RotorPlaneView.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit



class BalancePlaneView: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    var pCartesianTrans : CGAffineTransform = CGAffineTransformIdentity
    var vibScale: Float = Float(10.0)
    var rotateRotor : Float = Float(0.0)
    var vibScaleLineWidth : Float = Float(0.1)
    
    var vectorStrokeWidth : Float = 1.0
    var vectorArrowLength : Float = 1.0
    
    var xScale : Float = 0.0
    var yScale : Float = 0.0
    
    var viewScale: Float = 0.0
    
    override init(frame aRect: CGRect)
    {
        
        super.init(frame:aRect)
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
        
    }
    
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
        viewScale = vibScale * 1.2
        let context = UIGraphicsGetCurrentContext()
        var pTempCartesianTransform : CGAffineTransform = CGAffineTransformIdentity
        
        pTempCartesianTransform = CGAffineTransformTranslate(pTempCartesianTransform, (self.frame.size.width / 2), (self.frame.size.height / 2));
        
        xScale =  Float((self.frame.size.width / 2) / CGFloat(viewScale))
        yScale = Float(-1.0 * ( (self.frame.size.height / 2) / CGFloat(viewScale) ))
        
        pTempCartesianTransform = CGAffineTransformScale(pTempCartesianTransform, CGFloat(xScale), CGFloat(yScale));
        
        pTempCartesianTransform =  CGAffineTransformRotate(pTempCartesianTransform, CGFloat(rotateRotor))
        
        return pTempCartesianTransform
    }
    
    func GetRotatedTextTransform(At _point:CGPoint, Rotate _rotate:Float) -> CGAffineTransform
    {
        let rotationAngle = _rotate
        
        let context = UIGraphicsGetCurrentContext()
        var pTempTransform : CGAffineTransform = CGAffineTransformIdentity
        
        pTempTransform = CGAffineTransformTranslate(pTempTransform, _point.x, _point.y)
        pTempTransform = CGAffineTransformRotate(pTempTransform, CGFloat(rotationAngle) * -1.0 );
        
        pTempTransform =  CGAffineTransformRotate(pTempTransform, CGFloat(rotateRotor))
        
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
        let weightSlotRadius = vibScale * 0.1
        let strokeWidth = vibScaleLineWidth
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        let weightSlotCenter = Float( vibScale ) - Float(weightSlotRadius)
        
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
        CGContextAddArc(context, center.x, center.y, CGFloat(vibScale * 0.04), CGFloat(0), CGFloat(2.0 * M_PI), 1)
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.darkGrayColor().CGColor)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.darkGrayColor().CGColor)
        
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
        CGContextAddArc(context, center.x, center.y, CGFloat(vibScale), CGFloat(0), CGFloat(2.0 * M_PI), 1)
        
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
    
    func DrawVectorName(vector:Vector, RotateText _rotateText:Bool = false)
    {
        
        var midPoint : CGPoint = CGPoint(x:0, y:0)
        
        midPoint.x = CGFloat((vector.xOrigin + vector.xEnd) / Float(2))
        midPoint.y = CGFloat((vector.yOrigin + vector.yEnd) / Float(2))
        
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        var  textHeight:Float = Float(textFont.lineHeight) / (Float(2.0) * yScale)
        midPoint.y += CGFloat(textHeight)
        
        var  textSize = textFont.sizeOfString(vector.name)

        let sRect:CGRect = CGRectMake(0, 0, textSize.width*1.5, textSize.height)
        var aPoint:CGPoint = CGPointApplyAffineTransform ( midPoint, pCartesianTrans );
        
        var label = UILabel(frame: sRect)
        label.center = aPoint
        label.font = textFont
        label.textAlignment = NSTextAlignment.Center
        label.text = vector.name
        label.backgroundColor = UIColor.grayColor()
        label.layer.borderColor = UIColor.darkGrayColor().CGColor
        label.layer.borderWidth = 0.5
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        if(_rotateText)
        {
            var textRotation = CGFloat(GetRadians(vector.phase)) + CGFloat(rotateRotor)
            textRotation *= -1.0
            label.transform = CGAffineTransformMakeRotation( textRotation )
        }
        
        addSubview(label)
        
    }
    
    
    func GetArrowEnds( vector : Vector ) -> (xA:Float, yA:Float, xB:Float, yB:Float)
    {
        let arrowAngle : Float = 160
        let arrowLength : Float = vectorArrowLength
        
        var radiansA : Float = 0.0
        var radiansB : Float = 0.0
        
        var pphase = Float(vector.phase)
        
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
        CGContextSetStrokeColorWithColor(context, vector.color.CGColor)
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
        
        
        //Draw the vector base nob
        var startAngle: Float = Float(2.0 * M_PI)
        var endAngle: Float = 0.0
        
        // Find the middle of the circle
        let center = CGPointMake(0 , 0)
        
        // Draw the arc around the circle
        CGContextAddArc(context, CGFloat(vector.xOrigin), CGFloat(vector.yOrigin), CGFloat(vectorStrokeWidth*0.65), CGFloat(0), CGFloat(2.0 * M_PI), 1)
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, vector.color.CGColor)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, vector.color.CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        // end Draw vector base nob
        
        
        PopToDefaultTransform()
        
        DrawVectorName(vector)
        
    }
    
//    func DrawVectorLabelAt(Text _text:String, At _point:CGPoint, Rotate _rotate:Float, Size _size : Int)
//    {
//        
//        let fontName = "Helvetica"
//        let textFont:UIFont = UIFont(name: fontName, size: CGFloat(_size))!
//        
//        var  textHeight:Float = Float(textFont.lineHeight) / Float(2.0)
//        var txHeight = Float(textHeight) / yScale
//        
//        let adjustPoint:CGPoint = CGPoint(  x:_point.x, y: _point.y )
//        
//        var pPoint:CGPoint = CGPointApplyAffineTransform ( adjustPoint, pCartesianTrans );
//        
//        PushToTextTransform(At: pPoint, Rotate: GetRadians(_rotate) )
//        
//        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
//        textStyle.alignment = NSTextAlignment.Left
//        var tattribs = [NSFontAttributeName: textFont, NSParagraphStyleAttributeName: textStyle]
//        _text.drawAtPoint(CGPointMake(0,0), withAttributes: tattribs)
//        
//        PopToDefaultTransform()
//        
//    }
    

    
    func DrawTextLabel(At _point:CGPoint, Text _text:String)
    {
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        let sPoint:CGPoint = CGPoint(  x:_point.x, y: _point.y)
        let sRect:CGRect = CGRectMake(0, 0, 50, 10)
        var aPoint:CGPoint = CGPointApplyAffineTransform ( sPoint, pCartesianTrans );
        
        var label = UILabel(frame: sRect)
        label.center = aPoint
        label.font = textFont
        label.textAlignment = NSTextAlignment.Center
        label.text = _text
        //label.backgroundColor = UIColor.lightTextColor()
        //label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        addSubview(label)
    }
    
    func DrawDegreeLabel(At _point:CGPoint, Ratio _ratio:CGPoint, Degree _degree:Float)
    {
        
        let centerExtension:CGFloat = CGFloat( (viewScale - vibScale) / 2.0)
        
        let xExtension:CGFloat = centerExtension * _ratio.x
        let yExtension:CGFloat = centerExtension * _ratio.y
        
        let sPoint:CGPoint = CGPoint(  x:_point.x + xExtension, y: _point.y + yExtension)
        
        
        let degTextInt:NSNumber = Int(_degree)
        let degText:String = degTextInt.stringValue
        
        DrawTextLabel(At: sPoint, Text: degText)
        
    }
    
    
    func DrawRotorDegreeTics()
    {
        
        let context = UIGraphicsGetCurrentContext()
        
        let lineLength = ( (vibScale * 0.04) )
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vibScaleLineWidth))
        
        PushToCartesianTransform()
        for var index = 0; index < 360; index+=15
        {
            
            var xStart : Float = (vibScale - lineLength) * cos( GetRadians( Float(index) ) )
            var yStart : Float = (vibScale - lineLength) * sin( GetRadians( Float(index) ) )
            var xEnd   : Float = (vibScale) * cos( GetRadians( Float(index) ) )
            var yEnd   : Float = (vibScale) * sin( GetRadians( Float(index) ) )
            
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
            var textPoint:CGPoint = CGPoint(x:CGFloat(xEnd2 * vibScale), y:CGFloat(yEnd2 * vibScale))
            DrawDegreeLabel(At: textPoint, Ratio:ratioPoint, Degree:Float(index))
            
        }
        
    }
    
    func SetupScales(MaxVib _maxVib : Float)
    {
        //rotateRotor = Float(M_PI_2)
        
        vibScale = Float(_maxVib)
        vibScaleLineWidth = (vibScale * 0.01)
        vectorStrokeWidth = (vibScale * 0.02)
        vectorArrowLength = (vibScale * Float(0.05))
        
        
        InitalizeCartesianTransform()
    }
    
    
    
    override func drawRect(rect: CGRect)
    {
        
        SetupScales(MaxVib: 10.0)
        
        DrawRotor()
        
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        var weight : BalanceWeight = BalanceWeight(fromWeight : 5.0 , fromLocation : 44)
        DrawWeight(weight)
        
        var vec1 = Vector(fromAmp: 9, fromPhaseInDegrees: 70, withRunType: BalanceRunType.initial)
        drawVector(vec1)
        
        var vec2 = Vector(fromAmp: 10, fromPhaseInDegrees: 110, withRunType: BalanceRunType.influence)
        //drawVector(vec2)
        
        var vec3 = Vector(fromAmp: 7.5, fromPhaseInDegrees: 10)
        //drawVector(vec3)
        
        var vec4 = Vector(fromAmp: 9, fromPhaseInDegrees: 290)
        //drawVector(vec4)
        
        
        var vec5 = vec2 - vec1
        var vec6 = vec4 + vec1
        
        //drawVector(vec5)
        //drawVector(vec6)
        
        //        var vec5 = vec4 + (-1.0 * vec1)
        //        vec5.name = "vec5"
        //        drawVector(vec5)
        
        
    }
    
}
