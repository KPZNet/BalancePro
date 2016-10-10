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
    
    static let  VECTOR_TAIL_WIDTH = 2
    static let  VECTOR_HEAD_WIDTH = 10
    static let  VECTOR_HEAD_LENGTH = 10
    
}

class SinglePlaneVectorBalanceViewConfiguration : BalancePlaneView
{
    override func draw(_ rect: CGRect)
    {
        SetScales()
        self.layer.sublayers = nil
        DrawRotor()
        DrawRotorDegreeTics()
        DrawRotorDegreeTicLabels()
        
        let vScale = GetCurrentScale() * (0.75)
        let sampleVector = Vector(fromAmp: vScale, fromPhaseInDegrees: 45, withRunType:BalanceRunType.general)
        drawBVector(sampleVector, vectorColor: UIColor.black )
        ReleaseScales()
    }
    
}
class SinglePlaneVectorBalanceView : BalancePlaneView
{
    override func draw(_ rect: CGRect)
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

class BalancePlaneView: UIView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var pCartesianTrans : CGAffineTransform = CGAffineTransform.identity
    var vibScale: Float = Float(1.0)
    var rotateRotor : Float =  Float(0)
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
        UIGraphicsGetCurrentContext()?.saveGState()
        
        let context = UIGraphicsGetCurrentContext()
        context?.concatenate(pCartesianTrans);
        
    }
    func PopToDefaultTransform()
    {
        UIGraphicsGetCurrentContext()?.restoreGState()
    }
    func GetCartisianTransform() -> CGAffineTransform
    {
        
        viewScale = vibScale * 1.2
        
        var rotationScale:CGFloat = 1.0 //cw
        if(GetAppDelegate().singlePlaneBalance.shaftRotation == ShaftRotationType.ccw){
            rotationScale = -1.0
        }
        
        var pTempCartesianTransform : CGAffineTransform = CGAffineTransform.identity
        
        pTempCartesianTransform = pTempCartesianTransform.translatedBy(x: (self.frame.size.width / 2), y: (self.frame.size.height / 2));
        
        
        xScale =  Float(1.0 * (self.frame.size.width / 2) / CGFloat(viewScale))
        yScale =  Float(rotationScale * ( (self.frame.size.height / 2) / CGFloat(viewScale) ))
        
        pTempCartesianTransform = pTempCartesianTransform.scaledBy(x: CGFloat(xScale), y: CGFloat(yScale));
        
        pTempCartesianTransform =  pTempCartesianTransform.rotated(by: CGFloat(rotateRotor))
        
        return pTempCartesianTransform
    }
    
    func GetRotatedTextTransform(At _point:CGPoint, Rotate _rotate:Float) -> CGAffineTransform
    {
        let rotationAngle = _rotate
        
        var pTempTransform : CGAffineTransform = CGAffineTransform.identity
        
        pTempTransform = pTempTransform.translatedBy(x: _point.x, y: _point.y)
        pTempTransform = pTempTransform.rotated(by: CGFloat(rotationAngle) * -1.0 );
        
        pTempTransform =  pTempTransform.rotated(by: CGFloat(rotateRotor))
        
        return pTempTransform
    }
    
    func PushToTextTransform(At _point:CGPoint, Rotate _rotate:Float)
    {
        UIGraphicsGetCurrentContext()?.saveGState()
        
        let context = UIGraphicsGetCurrentContext()
        context?.concatenate(GetRotatedTextTransform(At:_point, Rotate:_rotate));
    }
    
    func ConvertVectorToXY(_ vector : Vector) -> (x:Float, y:Float)
    {
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radians : Float = 0.0
        radians = DegToRadConversion * Float(vector.phase)
        let magnitude = vector.amp
        
        let x = Float(  magnitude * cos( radians ))
        let y = Float(  magnitude * sin( radians ))
        
        return (x, y)
    }
    
    
    func DrawWeight( _ weight : BalanceWeight, color:UIColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.5) )
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
        
        let radians = Float(weight.location.DegreesToRadians())
        x = weightSlotCenter * cos( radians )
        y = weightSlotCenter * sin( radians )
        
        
        // Find the middle of the circle
        let center = CGPoint( x: CGFloat(x), y: CGFloat(y) )
        
        // Set the stroke color
        context?.setStrokeColor(UIColor.blue.cgColor)
        
        // Set the line width
        context?.setLineWidth(CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        context?.setFillColor(fillColor.cgColor)
        
        // Draw the arc around the circle
        //CGContextAddArc(context, center.x, center.y, CGFloat(weightSlotRadius), CGFloat(0), CGFloat(2 * M_PI), 1) kpc
        
        let startPoint = CGPoint(x: center.x, y: center.y)
        context?.addArc(center: startPoint, radius: CGFloat(weightSlotRadius), startAngle: CGFloat(0), endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        // Draw the arc
        context?.drawPath(using: CGPathDrawingMode.fillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
    }
    
    func DrawRotorCenterNob()
    {
        
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPoint(x: 0 , y: 0)
        
        // Draw the arc around the circle
        //CGContextAddArc(context, center.x, center.y, CGFloat(vibScale * 0.04), CGFloat(0), CGFloat(2.0 * M_PI), 1) kpc
        context?.addArc(center: center, radius: CGFloat(vibScale * 0.04), startAngle: CGFloat(0), endAngle: CGFloat(2.0 * M_PI), clockwise: true)
        
        // Set the fill color (if you are filling the circle)
        context?.setFillColor(UIColor.darkGray.cgColor)
        
        // Set the stroke color
        context?.setStrokeColor(UIColor.darkGray.cgColor)
        
        // Set the line width
        context?.setLineWidth(CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        context?.drawPath(using: CGPathDrawingMode.fillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
    }
    
    
    func DrawRotor()
    {
        
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPoint(x: 0 , y: 0)
        
        // Draw the arc around the circle
        //CGContextAddArc(context, center.x, center.y, CGFloat(vibScale), CGFloat(0), CGFloat(2.0 * M_PI), 1)  kpc
        
        context?.addArc(center: center, radius: CGFloat(vibScale), startAngle: CGFloat(0), endAngle: CGFloat(2.0 * M_PI), clockwise: true)
        
        // Set the fill color (if you are filling the circle)
        context?.setFillColor(UIColor.gray.cgColor)
        
        // Set the stroke color
        context?.setStrokeColor(UIColor.black.cgColor)
        
        // Set the line width
        context?.setLineWidth(CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        context?.drawPath(using: CGPathDrawingMode.fillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        DrawRotorCenterNob()
        
    }
    
    func DrawVectorName(_ vector:Vector, RotateText _rotateText:Bool = false)
    {
        
        var midPoint : CGPoint = CGPoint(x:0, y:0)
        
        midPoint.x = CGFloat((vector.xOrigin + vector.xEnd) / Float(2))
        midPoint.y = CGFloat((vector.yOrigin + vector.yEnd) / Float(2))
        
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        let  textSize = textFont.sizeOfString( NSString(string: vector.name + "XX") )
        
        let sRect:CGRect = CGRect(x: 0, y: 0, width: textSize.width, height: textSize.height)
        let aPoint:CGPoint = midPoint.applying (pCartesianTrans );
        
        let label = UILabel(frame: sRect)
        label.center = aPoint
        label.font = textFont
        label.textAlignment = NSTextAlignment.center
        
        label.text = vector.name
        label.backgroundColor = UIColor.lightGray
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.borderWidth = 0.5
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        if(_rotateText)
        {
            var textRotation = CGFloat( vector.phase.DegreesToRadians() ) + CGFloat(rotateRotor)
            textRotation *= -1.0
            label.transform = CGAffineTransform( rotationAngle: textRotation )
        }
        
        addSubview(label)
        
    }
    
    func DrawVectorEndCir(_ vector:Vector)
    {
        
        let fillColor : UIColor = UIColor(red: (160/255.0), green: (97/255.0), blue: (5/255.0), alpha: 0.2)
        
        // Get the context
        let context = UIGraphicsGetCurrentContext()
        
        // Draw the arc around the circle
        //CGContextAddArc(context, CGFloat(vector.xEnd), CGFloat(vector.yEnd), CGFloat(2), CGFloat(0), CGFloat(2.0 * M_PI), 1)  kpc
        
        context?.addArc(center: center, radius: CGFloat(vibScale), startAngle: CGFloat(0), endAngle: CGFloat(2.0 * M_PI), clockwise: true)
        
        // Set the fill color (if you are filling the circle)
        context?.setFillColor(fillColor.cgColor)
        
        // Set the stroke color
        context?.setStrokeColor(UIColor.black.cgColor)
        
        // Set the line width
        context?.setLineWidth(CGFloat(vibScaleLineWidth))
        
        // Draw the arc
        context?.drawPath(using: CGPathDrawingMode.fillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
    }
    
    func drawBVector(_ vector : Vector, vectorColor: UIColor = UIColor.black)
    {
        
        DrawArrow(viewControl:self,
                  basePoint: vector.basePoint.applying(pCartesianTrans),
                  endPoint: vector.endPoint.applying(pCartesianTrans),
                  tailWidth: CGFloat(CONSTANTS.VECTOR_TAIL_WIDTH),
                  headWidth: CGFloat(CONSTANTS.VECTOR_HEAD_WIDTH),
                  headLength: CGFloat(CONSTANTS.VECTOR_HEAD_LENGTH),
                  color:vectorColor)
        
        
        if(GetAppDelegate().preferences.showVectorLabel) {
            DrawVectorName(vector)
        }
        
        //DrawVectorEndCir(vector)
        
    }
    
    
    
    func DrawTextLabel(At _point:CGPoint, Text _text:String)
    {
        let textFont:UIFont = UIFont(name: "Helvetica", size: CGFloat(10))!
        
        let sPoint:CGPoint = CGPoint(  x:_point.x, y: _point.y)
        let sRect:CGRect = CGRect(x: 0, y: 0, width: 50, height: 10)
        let aPoint:CGPoint = sPoint.applying (pCartesianTrans );
        
        let label = UILabel(frame: sRect)
        label.center = aPoint
        label.font = textFont
        label.textAlignment = NSTextAlignment.center
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
        
        
        //let degTextInt:NSNumber = NSNumber(Int(_degree))  kpc
        let degTextInt:NSNumber = NSNumber(value: _degree)
        let degText:String = degTextInt.stringValue
        
        DrawTextLabel(At: sPoint, Text: degText)
        
    }
    
    
    func DrawRotorDegreeTics()
    {
        
        let context = UIGraphicsGetCurrentContext()
        
        let lineLength = ( (vibScale * 0.04) )
        
        // Set the stroke color
        context?.setStrokeColor(UIColor.black.cgColor)
        // Set the line width
        context?.setLineWidth(CGFloat(vibScaleLineWidth))
        
        //for var index = 0; index < 360; index+=15
        for index in stride(from: 0, to: 360, by: 15)
        {
            
            let xStart : Float = (vibScale - lineLength) * cos( index.DegreesToRadians() )
            let yStart : Float = (vibScale - lineLength) * sin( index.DegreesToRadians() )
            let xEnd   : Float = (vibScale) * cos( index.DegreesToRadians())
            let yEnd   : Float = (vibScale) * sin( index.DegreesToRadians())
            
            context?.move(to: CGPoint(x: CGFloat(xStart), y: CGFloat(yStart)))
            context?.addLine(to: CGPoint(x: CGFloat(xEnd), y: CGFloat(yEnd)))
            context?.strokePath()
            
        }
        
    }
    
    func DrawRotorDegreeTicLabels()
    {
        
        //for var index = 0; index < 360; index+=45
        for index in stride(from: 0, to: 360, by: 45)
        {
            
            let xEnd2   : Float = cos( index.DegreesToRadians())
            let yEnd2   : Float = sin( index.DegreesToRadians())
            let ratioPoint:CGPoint = CGPoint(x:CGFloat(xEnd2), y:CGFloat(yEnd2))
            let textPoint:CGPoint = CGPoint(x:CGFloat(xEnd2 * vibScale), y:CGFloat(yEnd2 * vibScale))
            DrawDegreeLabel(At: textPoint, Ratio:ratioPoint, Degree:Float(index))
            
        }
        
    }
    
    func GetCurrentScale() -> Float{
        return GetAppDelegate().singlePlaneBalance.GetVectorScale()
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
    
    
    
    
    override func draw(_ rect: CGRect)
    {
        
        
    }
    
    

    
    
}
