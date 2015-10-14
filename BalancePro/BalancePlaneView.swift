//
//  RotorPlaneView.swift
//  BalancePro
//
//  Created by KenCeglia on 11/18/14.
//  Copyright (c) 2014 KenCeglia. All rights reserved.
//

import UIKit



struct CONSTANTS {
    
    static let DEFAULT_VIB_SCALES = 10
    static let DEFAULT_LINE_STROKE_WIDTH = 0.1
    static let DEFAULT_VECTOR_STROKE_WIDTH = 0.2
    static let DEFAULT_WEIGHT_RADIUS = 0.7 //% OF VIB SCALE
    static let DEFAULT_TIC_LENGTH = 4
    static let  DEFAULT_ARROW_LENGTH = 0.5
    
}

class SinglePlaneVectorBalanceView : BalancePlaneView
{
    override func drawRect(rect: CGRect)
    {
        SetScales()
        self.layer.sublayers = nil
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect, vectorColor: initVect.color)
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                drawBVector(trialVect, vectorColor: trialVect.color)
                if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
                {
                    drawBVector(inflVect, vectorColor: inflVect.color)
                    
                    let TO = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                    drawBVector(TO, vectorColor: TO.color)
                    
                    if let finalVect = GetAppDelegate().singlePlaneBalance.finalVector
                    {
                        drawBVector(finalVect, vectorColor: finalVect.color)
                    }
                }
            }
        }
        if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
        {
            DrawWeight(wP)
        }
        if let balanceWeight = GetAppDelegate().singlePlaneBalance.balanceWeight
        {
            DrawWeight(balanceWeight, color:UIColor(red: (0/255.0), green: (255/255.0), blue: (0/255.0), alpha: 0.5))
        }
        ReleaseScales()
    }
    
}
class BalancePlaneViewFinalVector : BalancePlaneView
{
    override func drawRect(rect: CGRect)
    {
        SetScales()
        self.layer.sublayers = nil
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect, vectorColor: initVect.color)
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                drawBVector(trialVect, vectorColor: trialVect.color)
                if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
                {
                    drawBVector(inflVect, vectorColor: inflVect.color)
                    
                    let TO = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                    drawBVector(TO, vectorColor: TO.color)
                    
                    if let finalVect = GetAppDelegate().singlePlaneBalance.finalVector
                    {
                        drawBVector(finalVect, vectorColor: finalVect.color)
                    }
                }
            }
        }
        if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
        {
            DrawWeight(wP)
        }
        if let balanceWeight = GetAppDelegate().singlePlaneBalance.balanceWeight
        {
            DrawWeight(balanceWeight, color:UIColor(red: (0/255.0), green: (255/255.0), blue: (0/255.0), alpha: 0.5))
        }
        ReleaseScales()
    }
    
}

class BalancePlaneViewCalculationResults : BalancePlaneView
{
    
    override func drawRect(rect: CGRect)
    {
        SetScales()
        self.layer.sublayers = nil
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect, vectorColor: initVect.color)
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                drawBVector(trialVect, vectorColor: trialVect.color)
                if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
                {
                    drawBVector(inflVect, vectorColor: inflVect.color)
                    
                    let TO = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                    drawBVector(TO, vectorColor: TO.color)
                }
            }
        }
        
        if let wPF = GetAppDelegate().singlePlaneBalance.balanceWeight
        {
            DrawWeight(wPF, color:UIColor(red: (0/255.0), green: (255/255.0), blue: (0/255.0), alpha: 0.5))
            
        }
        ReleaseScales()
    }
    
}

class BalancePlaneViewInfluenceVector : BalancePlaneView
{
    
    override func drawRect(rect: CGRect)
    {
        SetScales()
        self.layer.sublayers = nil
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect, vectorColor: initVect.color)
            if let trialVect = GetAppDelegate().singlePlaneBalance.trialVector
            {
                drawBVector(trialVect, vectorColor: trialVect.color)
                if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
                {
                    drawBVector(inflVect, vectorColor: inflVect.color)
                    
                    let TO = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                    drawBVector(TO, vectorColor: TO.color)
                }
            }
        }
        
        if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
        {
            DrawWeight(wP)
        }
        ReleaseScales()
        
    }
    
}

class BalancePlaneViewTrialWeight : BalancePlaneView
{
    
    override func drawRect(rect: CGRect)
    {
        SetScales()
        self.layer.sublayers = nil
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(initVect,vectorColor:initVect.color)
        }
        
        if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
        {
            DrawWeight(wP)
        }
        ReleaseScales()
    }
    
}
class BalancePlaneViewInitialVector : BalancePlaneView
{
    
    override func drawRect(rect: CGRect)
    {
        SetScales()
        
        self.layer.sublayers = nil
        
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        if let vect = GetAppDelegate().singlePlaneBalance.initialVector
        {
            drawBVector(vect, vectorColor:vect.color)
        }
        ReleaseScales()
    }
    
}


class BalancePlaneView: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    var pCartesianTrans : CGAffineTransform = CGAffineTransformIdentity
    var vibScale: Float = Float(1.0)
    var rotateRotor : Float =  Float(M_PI)
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
    
    required init?(coder aDecoder: NSCoder)
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

        var pTempCartesianTransform : CGAffineTransform = CGAffineTransformIdentity
        
        pTempCartesianTransform = CGAffineTransformTranslate(pTempCartesianTransform, (self.frame.size.width / 2), (self.frame.size.height / 2));
        
        xScale =  Float((self.frame.size.width / 2) / CGFloat(viewScale))
        yScale = Float(1.0 * ( (self.frame.size.height / 2) / CGFloat(viewScale) ))
        
        pTempCartesianTransform = CGAffineTransformScale(pTempCartesianTransform, CGFloat(xScale), CGFloat(yScale));
        
        pTempCartesianTransform =  CGAffineTransformRotate(pTempCartesianTransform, CGFloat(rotateRotor))
        
        return pTempCartesianTransform
    }
    
    func GetRotatedTextTransform(At _point:CGPoint, Rotate _rotate:Float) -> CGAffineTransform
    {
        let rotationAngle = _rotate

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
        let magnitude = vector.amp
        
        let x = Float(  magnitude * cos( radians ))
        let y = Float(  magnitude * sin( radians ))
        
        return (x, y)
    }
    
    func GetRadians(deg : Float) -> Float
    {
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radian : Float = 0.0
        
        radian = DegToRadConversion * Float(deg)
        
        return radian
    }
    
    
    
    func DrawWeight( weight : BalanceWeight, color:UIColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.5) )
    {
        var x : Float
        var y : Float
        
        // Drawing code
        // Set the radius
        let weightSlotRadius = vibScale * 0.07
        let strokeWidth = vibScaleLineWidth
        
        let fillColor : UIColor = color
        
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        let weightSlotCenter = Float( vibScale ) //- Float(weightSlotRadius)
        
        let radians = GetRadians( Float(weight.location) )
        x = weightSlotCenter * cos( radians )
        y = weightSlotCenter * sin( radians )
        
        
        // Find the middle of the circle
        let center = CGPointMake( CGFloat(x), CGFloat(y) )
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, fillColor.CGColor)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(weightSlotRadius), CGFloat(0), CGFloat(2 * M_PI), 1)
        
        // Draw the arc
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
    }
    
    func DrawRotorCenterNob()
    {
        
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
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke) // or kCGPathFillStroke to fill and stroke the circle

    }
    
    
    func DrawRotor()
    {
     
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
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        DrawRotorCenterNob()
        
    }
    
    func DrawVectorName(vector:Vector, RotateText _rotateText:Bool = false)
    {
        
        var midPoint : CGPoint = CGPoint(x:0, y:0)
        
        midPoint.x = CGFloat((vector.xOrigin + vector.xEnd) / Float(2))
        midPoint.y = CGFloat((vector.yOrigin + vector.yEnd) / Float(2))
        
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        let  textSize = textFont.sizeOfString(vector.name + "XX")
        
        let sRect:CGRect = CGRectMake(0, 0, textSize.width, textSize.height)
        let aPoint:CGPoint = CGPointApplyAffineTransform ( midPoint, pCartesianTrans );
        
        let label = UILabel(frame: sRect)
        label.center = aPoint
        label.font = textFont
        label.textAlignment = NSTextAlignment.Center
        
        label.text = vector.name
        label.backgroundColor = UIColor.lightGrayColor()
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
    
    func DrawVectorEndCir(vector:Vector)
    {
        
        let fillColor : UIColor = UIColor(red: (160/255.0), green: (97/255.0), blue: (5/255.0), alpha: 0.2)
        
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Draw the arc around the circle
        CGContextAddArc(context, CGFloat(vector.xEnd), CGFloat(vector.yEnd), CGFloat(2), CGFloat(0), CGFloat(2.0 * M_PI), 1)
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, fillColor.CGColor)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
    }
    
    func drawBVector(vector : Vector, vectorColor: UIColor = UIColor.blackColor())
    {
       
        DrawArrow(viewControl:self,
            basePoint: CGPointApplyAffineTransform(vector.basePoint, pCartesianTrans),
            endPoint: CGPointApplyAffineTransform(vector.endPoint, pCartesianTrans),
            tailWidth: CGFloat(3),
            headWidth: CGFloat(7),
            headLength: CGFloat(10.0),
            color:vectorColor)
        
        DrawVectorName(vector)
        //DrawVectorEndCir(vector)
        
    }
    
    
    
    func DrawTextLabel(At _point:CGPoint, Text _text:String)
    {
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        let sPoint:CGPoint = CGPoint(  x:_point.x, y: _point.y)
        let sRect:CGRect = CGRectMake(0, 0, 50, 10)
        let aPoint:CGPoint = CGPointApplyAffineTransform ( sPoint, pCartesianTrans );
        
        let label = UILabel(frame: sRect)
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
        
        for var index = 0; index < 360; index+=15
        {
            
            let xStart : Float = (vibScale - lineLength) * cos( GetRadians( Float(index) ) )
            let yStart : Float = (vibScale - lineLength) * sin( GetRadians( Float(index) ) )
            let xEnd   : Float = (vibScale) * cos( GetRadians( Float(index) ) )
            let yEnd   : Float = (vibScale) * sin( GetRadians( Float(index) ) )
            
            CGContextMoveToPoint(context, CGFloat(xStart), CGFloat(yStart))
            CGContextAddLineToPoint(context, CGFloat(xEnd), CGFloat(yEnd))
            CGContextStrokePath(context)
            
        }
        
    }
    
    func DrawRotorDegreeTicLabels()
    {
        
        for var index = 0; index < 360; index+=45
        {
            
            let xEnd2   : Float = cos( GetRadians( Float(index) ) )
            let yEnd2   : Float = sin( GetRadians( Float(index) ) )
            let ratioPoint:CGPoint = CGPoint(x:CGFloat(xEnd2), y:CGFloat(yEnd2))
            let textPoint:CGPoint = CGPoint(x:CGFloat(xEnd2 * vibScale), y:CGFloat(yEnd2 * vibScale))
            DrawDegreeLabel(At: textPoint, Ratio:ratioPoint, Degree:Float(index))
            
        }
        
    }
    
    func SetScales()
    {
        SetupScales(MaxVib: GetAppDelegate().singlePlaneBalance.GetVectorScale() )
        PushToCartesianTransform()
    }
    func ReleaseScales()
    {
        PopToDefaultTransform()
    }
    
    func SetupScales(MaxVib _maxVib : Float)
    {
        if(_maxVib > vibScale){
            
            vibScale = Float(_maxVib * 1.1)
        }
        vibScaleLineWidth = (vibScale * 0.01)
        vectorStrokeWidth = (vibScale * 0.02)
        vectorArrowLength = (vibScale * Float(0.05))
        
        InitalizeCartesianTransform()
    }
    
    
    func DrawBlankRect(){
        
        let r = self.bounds
        /* Create the path first. Just the path handle. */
        let path = CGPathCreateMutable()
        
        /* Here are our first rectangle boundaries */
        let rectangle1 = r //CGRect(x: 10, y: 30, width: 200, height: 300)
        
        /* And the second rectangle */
        let rectangle2 = r //CGRect(x: 40, y: 100, width: 90, height: 300)
        
        /* Put both rectangles into an array */
        let rectangles = [rectangle1, rectangle2]
        
        /* Add the rectangles to the path */
        CGPathAddRects(path, nil, rectangles, 2)
        
        /* Get the handle to the current context */
        let currentContext = UIGraphicsGetCurrentContext()
        
        /* Add the path to the context */
        CGContextAddPath(currentContext, path)
        
        /* Set the fill color to cornflower blue */
        UIColor.grayColor().setFill()
        //UIColor(red: 0.20, green: 0.60, blue: 0.80, alpha: 1.0).setFill()
        
        /* Set the stroke color to black */
        //UIColor.blackColor().setStroke()
        
        /* Set the line width (for the stroke) to 5 */
        //CGContextSetLineWidth(currentContext, 5)
        
        /* Stroke and fill the path on the context */
        CGContextDrawPath(currentContext, CGPathDrawingMode.FillStroke)
    }
    
    
    override func drawRect(rect: CGRect)
    {
        
        
    }
    
}
