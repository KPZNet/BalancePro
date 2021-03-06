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

enum ShaftRotationType {case cw, ccw}
enum BalanceRunType {case initial, influence, influenceOrigin, trial, final, general}
enum RUN_TYPE { case single_PLANE_VECTOR, double_PLANE_VECTOR, four_RUN_SINGLE_PLANE, four_RUN_DOUBLE_PLANE}

class Preferences {
    var showVectorLabel : Bool = true
}

func GetAppDelegate() -> AppDelegate
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate
}

func CalcAngleDegreesBetweenVectors(_ _v1:Vector, _v2:Vector) -> Float
{
    let v1Phase = _v1.phase
    let v2Phase = _v2.phase
    
    var deg = Float(v1Phase - v2Phase)
    if deg < 0.0 { deg += 360 }
    
    return deg
}

func CalcBalanceWeight() -> BalanceWeight
{
    var balWeight:BalanceWeight = BalanceWeight()
    
    if let initVect = GetAppDelegate().singlePlaneBalance.initialVector
    {
        if let inflVect = GetAppDelegate().singlePlaneBalance.influenceVector
        {
            if let wP = GetAppDelegate().singlePlaneBalance.influenceBalanceWeight
            {
                let inflVectOrigin = Vector(fromAmp: inflVect.amp, fromPhaseInDegrees: inflVect.phase, withRunType:BalanceRunType.influenceOrigin)
                
                let initVectNeg = -1*initVect
                
                let influenceVectOrigAmp = inflVectOrigin.amp
                let initVectAmp = initVect.amp
                
                let balanceWeightRatio:Float = wP.weight/influenceVectOrigAmp
                let bW = balanceWeightRatio * initVectAmp
                
                let deg = CalcAngleDegreesBetweenVectors(initVectNeg, _v2: inflVectOrigin)
                let wL = (wP.location + deg).truncatingRemainder(dividingBy: 360)
                
                let bWeight:BalanceWeight = BalanceWeight(fromWeight: bW, fromLocation: wL)
                
                balWeight = bWeight
            }
        }
    }
    
    return balWeight
}

class Balance {
    
    var shaftRotation : ShaftRotationType = ShaftRotationType.ccw
}

class SinglePlaneVectorBalance : Balance {
    
    var initialVector:Vector?
    var influenceVector:Vector?
    var trialVector:Vector?
    var finalVector:Vector?
    var influenceBalanceWeight:BalanceWeight?
    var balanceWeight:BalanceWeight?
    
    var currentScale:Float = 1.0
    
    override init(){
        
    }
    
    func GetVectorScale() -> Float{
        
        var maxScale:Float = 0.0
        
        if let _initVector = initialVector
        {
            maxScale = max(maxScale, _initVector.amp)
        }
        if let _influenceVector = influenceVector
        {
            maxScale = max(maxScale, _influenceVector.amp)
        }
        if let _trialVector = trialVector
        {
            maxScale = max(maxScale, _trialVector.amp)
        }
        
        if let _finalVector = finalVector
        {
            maxScale = max(maxScale, _finalVector.amp)
        }
        
        
        currentScale = max(currentScale,maxScale*Float(1.0))
        return currentScale
    }
    
}

func SetRoundedViewBox(forView _forView:UIView)
{
    _forView.layer.cornerRadius = 5.0
    _forView.layer.masksToBounds = true
    _forView.layer.borderWidth = 0.5
    _forView.layer.borderColor = UIColor.black.cgColor
}

func SetRoundedButton(forButton _forButton:UIButton)
{
    _forButton.layer.cornerRadius = 5.0
    _forButton.layer.masksToBounds = true
    _forButton.layer.borderWidth = 0.5
    _forButton.layer.borderColor = UIColor.black.cgColor
}

class Vector
{
    
    var xOrigin : Float = 0.0
    var yOrigin : Float = 0.0
    var xEnd : Float = 0.0
    var yEnd : Float = 0.0
    
    var userName : String = "user"
    var userColor : UIColor = UIColor.orange
    
    var runType :BalanceRunType = BalanceRunType.general
    
    var basePoint:CGPoint
        {
        get{
            let point:CGPoint = CGPoint( x: CGFloat(xOrigin), y: CGFloat(yOrigin) )
            return point
        }
        
    }
    var endPoint:CGPoint
        {
        get{
            let point:CGPoint = CGPoint( x: CGFloat(xEnd), y: CGFloat(yEnd) )
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
                
            }
            return returnName
        }
    }
    
    var color: UIColor
        {
        get{
            var returnColor = UIColor.blue
            switch (runType) {
            case BalanceRunType.general:
                returnColor = UIColor.blue
                break;
                
            case BalanceRunType.initial:
                returnColor = UIColor.white
                break;
                
            case BalanceRunType.influence:
                returnColor =  UIColor(red: (255/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.3)
                break;
                
            case BalanceRunType.influenceOrigin:
                returnColor = UIColor.red
                break;
                
            case BalanceRunType.final:
                returnColor = UIColor.orange
                break;
                
            default:
                returnColor = UIColor.blue
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
            
            let phase = radians.RadiansToDegrees()
            return phase
        }
    }
    
    init()
    {
        
    }
    init(fromAmp _amp : Float, fromPhaseInDegrees _phase : Float, withRunType _runType:BalanceRunType = BalanceRunType.general)
    {
        runType = _runType
        
        let radians = _phase.DegreesToRadians()
        
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
    
    let vecSub = Vector(xOrigin: 0,
                        yOrigin: 0,
                        xEnd: right.xEnd * left,
                        yEnd: right.yEnd * left)
    
    return vecSub
}
func +(left:Vector, right:Vector) -> Vector
{
    
    let vecSub = Vector(xOrigin: right.xOrigin + left.xOrigin,
                        yOrigin: right.yOrigin + left.yOrigin,
                        xEnd: right.xEnd + left.xEnd,
                        yEnd: right.yEnd + left.yEnd)
    
    return vecSub
}
func -(left:Vector, right:Vector) -> Vector
{
    let vecSub = Vector(xOrigin: right.xEnd, yOrigin: right.yEnd, xEnd: left.xEnd, yEnd: left.yEnd)
    
    return vecSub
}

func max(_ left:CGSize, right:CGSize) -> CGSize
{
    let newSize : CGSize = CGSize(width: max(left.width, right.width),
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
    func sizeOfString (_ string: NSString) -> CGSize
    {
        return string.boundingRect(with: CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude),
                                   options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                   attributes: [NSAttributedString.Key.font: self],
                                   context: nil).size
    }
}



func DrawArrow(viewControl _view:UIView, basePoint _basePoint:CGPoint, endPoint _endPoint:CGPoint,
               tailWidth _tailWidth: CGFloat,
               headWidth _headWidth: CGFloat,
               headLength _headLength:CGFloat,
               color _color:UIColor)
{
    
    let path:UIBezierPath = UIBezierPath.GetBezierArrowPathFromPoint(
        _basePoint,
        endPoint: _endPoint,
        tailWidth: _tailWidth,
        headWidth: _headWidth,
        headLength: _headLength)
    
    
    let shape : CAShapeLayer = CAShapeLayer()
    shape.path = path.cgPath;
    shape.fillColor = _color.cgColor
    
    _view.layer.addSublayer(shape)
}





extension Float {
    func string(_ fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
extension Float {
    func DegreesToRadians() -> Float{
        
        let DegreesToRad : Float = Float(Double.pi) / Float(180)
        return self * DegreesToRad
    }
}
extension Float {
    func RadiansToDegrees() -> Float{
        
        let RadToDegreesConversion : Float = Float(180) / Float(Double.pi)
        return self * RadToDegreesConversion
    }
}
extension CGFloat {
    func DegreesToRadians() -> CGFloat{
        
        let DegreesToRad : CGFloat = CGFloat(Double.pi) / CGFloat(180)
        return self * DegreesToRad
    }
}
extension CGFloat {
    func RadiansToDegrees() -> CGFloat{
        
        let RadToDegreesConversion : CGFloat = CGFloat(180) / CGFloat(Double.pi)
        return self * RadToDegreesConversion
    }
}

extension Int {
    func DegreesToRadians() -> Float{
        
        let DegreesToRad : Float = Float(Double.pi) / Float(180)
        let retValue : Float = Float( Float(self) * DegreesToRad)
        return retValue
    }
}
extension Int {
    func RadiansToDegrees() -> Float{
        
        let RadToDegreesConversion : Float = Float(180) / Float(Double.pi)
        let retValue : Float = Float( Float(self) * RadToDegreesConversion)
        return retValue
    }
}


extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension String {
    func ToFloat() -> Float{
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: self)
        let numberFloatValue = number!.floatValue
        return numberFloatValue
    }
}

extension UIBezierPath {
    
    class func GetVectorAlignedPoints(_ points: inout Array<CGPoint>, forLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat )
    {
        
        let tailLength = forLength - headLength
        points.append(CGPoint(x: 0, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: headWidth/2))
        points.append(CGPoint(x: forLength, y: 0))
        points.append(CGPoint(x: tailLength, y: -headWidth/2))
        points.append(CGPoint(x: tailLength, y: -tailWidth/2))
        points.append(CGPoint(x: 0, y: -tailWidth/2))
        
    }
    
    
    class func MakeTransformForStartPoint(_ startPoint: CGPoint, endPoint: CGPoint, length: CGFloat) -> CGAffineTransform
    {
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: startPoint.x, ty: startPoint.y)
    }
    
    
    class func GetBezierArrowPathFromPoint(_ startPoint:CGPoint, endPoint: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath
    {
        
        let length = hypotf(Float(endPoint.x) - Float(startPoint.x), Float(endPoint.y) - Float(startPoint.y))
        
        var points = [CGPoint]()
        self.GetVectorAlignedPoints(&points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        let transform: CGAffineTransform = self.MakeTransformForStartPoint(startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        let cgPath: CGMutablePath = CGMutablePath()
        
        cgPath.addLines(between: points, transform: transform)
        
        cgPath.closeSubpath()
        
        let uiPath: UIBezierPath = UIBezierPath(cgPath: cgPath)
        return uiPath
    }
}





