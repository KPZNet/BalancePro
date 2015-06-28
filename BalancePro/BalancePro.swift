//
//  BalancePro.swift
//  BalancePro
//
//  Created by KenCeglia on 5/4/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

enum RotationDirection {case cw, ccw}
enum BalanceRunType {case initial, influence, influenceOrigin, trial, final, general}

func GetAppDelegate() -> AppDelegate
{
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    return appDelegate
}


class SinglePlaneVectorBalance {
    
    var initialVector:Vector?
    var influenceVector:Vector?
    var trialVector:Vector?
    var finalVector:Vector?
    var influenceBalanceWeight:BalanceWeight?
    var balanceWeight:BalanceWeight?
    
    var currentScale:Float = 1.0
    
    init(){
        
    }
    
    func GetVectorScale() -> Float{
        
        var maxScale:Float = 0.0
        
        if let _initVector = initialVector
        {
            maxScale = max(maxScale, _initVector.amp)
            if let _influenceVector = influenceVector
            {
                maxScale = max(maxScale, _influenceVector.amp)
                if let _trialVector = trialVector
                {
                    maxScale = max(maxScale, _trialVector.amp)
                    if let _finalVector = finalVector
                    {
                        maxScale = max(maxScale, _trialVector.amp)
                    }
                }
            }
        }
        currentScale = max(currentScale,maxScale*Float(1.0))
        return currentScale
    }
    
}

func ClassName(forObject _forObject:Any) -> String
{
    return _stdlib_getDemangledTypeName(_forObject).componentsSeparatedByString(".").last!
}

func SetRoundedViewBox(forView _forView:UIView)
{
    _forView.layer.cornerRadius = 5.0
    _forView.layer.masksToBounds = true
    _forView.layer.borderWidth = 0.5
    _forView.layer.borderColor = UIColor.blackColor().CGColor
}

func SetRoundedButton(forButton _forButton:UIButton)
{
    _forButton.layer.cornerRadius = 5.0
    _forButton.layer.masksToBounds = true
    _forButton.layer.borderWidth = 0.5
    _forButton.layer.borderColor = UIColor.blackColor().CGColor
}

class Vector
{
    
    var xOrigin : Float = 0.0
    var yOrigin : Float = 0.0
    var xEnd : Float = 0.0
    var yEnd : Float = 0.0
    
    var userName : String = "user"
    var userColor : UIColor = UIColor.orangeColor()
    
    var runType :BalanceRunType = BalanceRunType.general
    
    var basePoint:CGPoint
        {
        get{
            var point:CGPoint = CGPointMake( CGFloat(xOrigin), CGFloat(yOrigin) )
            return point
        }
        
    }
    var endPoint:CGPoint
        {
        get{
            var point:CGPoint = CGPointMake( CGFloat(xEnd), CGFloat(yEnd) )
            return point
        }
        
    }
    
    var name: String
        {
        get{
            var returnName = "empty"
            switch (runType) {
            case BalanceRunType.general:
                returnName = "General"
                break;
                
            case BalanceRunType.general:
                returnName = "General"
                break;
                
            case BalanceRunType.initial:
                returnName = "Initial"
                break;
                
            case BalanceRunType.influence:
                returnName = "Influence"
                break;
                
            case BalanceRunType.influenceOrigin:
                returnName = "Influence"
                break;
                
            case BalanceRunType.trial:
                returnName = "Trial"
                break;
                
            case BalanceRunType.final:
                returnName = "Final"
                break;
                
            default:
                returnName = "General"
                break;
            }
            return returnName
        }
    }
    
    var color: UIColor
        {
        get{
            var returnColor = UIColor.blueColor()
            switch (runType) {
            case BalanceRunType.general:
                returnColor = UIColor.blueColor()
                break;
                
            case BalanceRunType.general:
                returnColor = UIColor.blueColor()
                break;
                
            case BalanceRunType.initial:
                returnColor = UIColor.whiteColor()
                break;
                
            case BalanceRunType.influence:
                returnColor = UIColor.redColor()
                break;
                
            case BalanceRunType.influenceOrigin:
                returnColor =  UIColor(red: (255/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.3)
                break;
                
            case BalanceRunType.final:
                returnColor = UIColor.orangeColor()
                break;
                
            default:
                returnColor = UIColor.blueColor()
                break;
            }
            return returnColor
        }
    }
    
    
    var amp : Float
        {
        
        get {
            let tempX :Float = xEnd - xOrigin
            let tempY :Float = yEnd - yOrigin
            
            let radians = atan2( tempY , tempX )
            
            let RadToDegreesConversion : Float = Float(180) / Float(M_PI)
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
            
            let RadToDegreesConversion : Float = Float(180) / Float(M_PI)
            let phase = RadToDegreesConversion * Float(radians)
            return phase
        }
    }
    
    init()
    {
        
    }
    init(fromAmp _amp : Float, fromPhaseInDegrees _phase : Float, withRunType _runType:BalanceRunType = BalanceRunType.general)
    {
        runType = _runType
        
        let DegToRadConversion : Float = Float(M_PI) / Float(180)
        var radians : Float = 0.0
        radians = DegToRadConversion * Float(_phase)
        
        xEnd = Float(  _amp * cos( radians ))
        yEnd = Float(  _amp * sin( radians ))
        
    }
    init(xOrigin _xOrigin:Float, yOrigin _yOrigin:Float, xEnd _xEnd:Float, yEnd _yEnd:Float, withRunType _runType:BalanceRunType = BalanceRunType.general)
    {
        runType = _runType
        
        xOrigin = _xOrigin
        yOrigin = _yOrigin
        
        xEnd = _xEnd
        yEnd = _yEnd
        
    }
    func string() -> String
    {
        var str:String = String("")
        str = amp.string(2) + "@" + phase.string(0)
        return str
    }
}

func *(left:Float, right:Vector) -> Vector
{
    
    var vecSub = Vector(xOrigin: 0,
        yOrigin: 0,
        xEnd: right.xEnd * left,
        yEnd: right.yEnd * left)
    
    return vecSub
}
func +(left:Vector, right:Vector) -> Vector
{
    
    var vecSub = Vector(xOrigin: right.xOrigin + left.xOrigin,
        yOrigin: right.yOrigin + left.yOrigin,
        xEnd: right.xEnd + left.xEnd,
        yEnd: right.yEnd + left.yEnd)
    
    return vecSub
}
func -(left:Vector, right:Vector) -> Vector
{
    var vecSub = Vector(xOrigin: right.xEnd, yOrigin: right.yEnd, xEnd: left.xEnd, yEnd: left.yEnd)
    
    return vecSub
}

func max(left:CGSize, right:CGSize) -> CGSize
{
    var newSize : CGSize = CGSize(width: max(left.width, right.width),
        height: max(left.height, right.height) )
    return newSize
}

class BalanceWeight
{
    var weight : Float
    var location : Float
    
    init()
    {
        weight = 0.0
        location = 0.0
    }
    init(fromWeight _weight : Float, fromLocation _location : Float)
    {
        weight = _weight
        location = _location
    }
    
    func string() -> String
    {
        var str:String = String("")
        str = weight.string(2) + "@" + location.string(0)
        return str
    }
}



extension UIFont {
    func sizeOfString (string: NSString) -> CGSize
    {
        return string.boundingRectWithSize(CGSize(width: DBL_MAX, height: DBL_MAX),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
}



func DrawArrow(viewControl _view:UIView, basePoint _basePoint:CGPoint, endPoint _endPoint:CGPoint,
    tailWidth _tailWidth: CGFloat,
    headWidth _headWidth: CGFloat,
    headLength _headLength:CGFloat,
    color _color:UIColor)
{
    var path:UIBezierPath = UIBezierPath.GetBezierArrowPathFromPoint(
        _basePoint,
        endPoint: _endPoint,
        tailWidth: _tailWidth,
        headWidth: _headWidth,
        headLength: _headLength)
    
    var shape : CAShapeLayer = CAShapeLayer()
    shape.path = path.CGPath;
    shape.fillColor = _color.CGColor
    
    _view.layer.addSublayer(shape)
}


extension UIBezierPath {
    
    class func GetVectorAlignedPoints(inout points: Array<CGPoint>, forLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat )
    {
        
        let tailLength = forLength - headLength
        points.append(CGPointMake(0, tailWidth/2))
        points.append(CGPointMake(tailLength, tailWidth/2))
        points.append(CGPointMake(tailLength, headWidth/2))
        points.append(CGPointMake(forLength, 0))
        points.append(CGPointMake(tailLength, -headWidth/2))
        points.append(CGPointMake(tailLength, -tailWidth/2))
        points.append(CGPointMake(0, -tailWidth/2))
        
    }
    
    
    class func MakeTransformForStartPoint(startPoint: CGPoint, endPoint: CGPoint, length: CGFloat) -> CGAffineTransform
    {
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return CGAffineTransformMake(cosine, sine, -sine, cosine, startPoint.x, startPoint.y)
    }
    
    
    class func GetBezierArrowPathFromPoint(startPoint:CGPoint, endPoint: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath
    {
        let NUM_VECTOR_POINTS = 7
        
        let length = hypotf(Float(endPoint.x) - Float(startPoint.x), Float(endPoint.y) - Float(startPoint.y))
        
        var points = [CGPoint]()
        self.GetVectorAlignedPoints(&points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        var transform: CGAffineTransform = self.MakeTransformForStartPoint(startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        var cgPath: CGMutablePathRef = CGPathCreateMutable()
        CGPathAddLines(cgPath, &transform, points, NUM_VECTOR_POINTS)
        CGPathCloseSubpath(cgPath)
        
        var uiPath: UIBezierPath = UIBezierPath(CGPath: cgPath)
        return uiPath
    }
}


extension Float {
    func string(fractionDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}



