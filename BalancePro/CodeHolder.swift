//
//  CodeHolder.swift
//  BalancePro
//
//  Created by KenCeglia on 1/8/15.
//  Copyright (c) 2015 KenCeglia. All rights reserved.
//

import Foundation

//
//#import "UIBezierPath+dqd_arrowhead.h"
//
//#define kArrowPointCount 7
//
//@implementation UIBezierPath (dqd_arrowhead)
//
//+ (UIBezierPath *)dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint
//toPoint:(CGPoint)endPoint
//tailWidth:(CGFloat)tailWidth
//headWidth:(CGFloat)headWidth
//headLength:(CGFloat)headLength {
//    CGFloat length = hypotf(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
//    
//    CGPoint points[kArrowPointCount];
//    [self dqd_getAxisAlignedArrowPoints:points
//        forLength:length
//        tailWidth:tailWidth
//        headWidth:headWidth
//        headLength:headLength];
//    
//    CGAffineTransform transform = [self dqd_transformForStartPoint:startPoint
//        endPoint:endPoint
//        length:length];
//    
//    CGMutablePathRef cgPath = CGPathCreateMutable();
//    CGPathAddLines(cgPath, &transform, points, sizeof points / sizeof *points);
//    CGPathCloseSubpath(cgPath);
//    
//    UIBezierPath *uiPath = [UIBezierPath bezierPathWithCGPath:cgPath];
//    CGPathRelease(cgPath);
//    return uiPath;
//    }
//    
//    + (void)dqd_getAxisAlignedArrowPoints:(CGPoint[kArrowPointCount])points
//forLength:(CGFloat)length
//tailWidth:(CGFloat)tailWidth
//headWidth:(CGFloat)headWidth
//headLength:(CGFloat)headLength {
//    CGFloat tailLength = length - headLength;
//    points[0] = CGPointMake(0, tailWidth / 2);
//    points[1] = CGPointMake(tailLength, tailWidth / 2);
//    points[2] = CGPointMake(tailLength, headWidth / 2);
//    points[3] = CGPointMake(length, 0);
//    points[4] = CGPointMake(tailLength, -headWidth / 2);
//    points[5] = CGPointMake(tailLength, -tailWidth / 2);
//    points[6] = CGPointMake(0, -tailWidth / 2);
//    }
//    
//    + (CGAffineTransform)dqd_transformForStartPoint:(CGPoint)startPoint
//endPoint:(CGPoint)endPoint
//length:(CGFloat)length {
//    CGFloat cosine = (endPoint.x - startPoint.x) / length;
//    CGFloat sine = (endPoint.y - startPoint.y) / length;
//    return (CGAffineTransform){ cosine, sine, -sine, cosine, startPoint.x, startPoint.y };
//}


//override func drawRect(rect: CGRect)
//{
//    //    let fontName = "HelveticaNeue-Bold"
//    //    let helveticaBold = UIFont(name: fontName, size: 40.0)
//    //    let string = "Some String" as NSString
//    //    string.drawAtPoint(CGPointMake(40.0, 180.0),
//    //      withAttributes: [NSFontAttributeName : helveticaBold!])
//    
//    
//    let _text:String = "ASDFASDFA"
//    
//    
//    let fontName = "Helvetica"
//    let textFont:UIFont = UIFont(name: fontName, size: CGFloat(14))!
//    
//    let adjustedRect:CGRect = CGRect(   x:30,
//        y: 100,
//        width:100,
//        height:20)
//    
//    
//    let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
//    textStyle.alignment = NSTextAlignment.Left
//    var tattribs = [NSFontAttributeName: textFont,
//        NSParagraphStyleAttributeName: textStyle]
//    _text.drawInRect(adjustedRect, withAttributes: tattribs)
//    
//}




//let adjustedRect:CGRect = CGRect(   x:0,
//    y: 10,
//    width:100,
//    height:20)
//
//var label = UILabel(frame: adjustedRect)
////label.center = CGPointMake(0, 0)
//label.textAlignment = NSTextAlignment.Center
//label.text = "KLabel"
//label.backgroundColor = UIColor.blueColor()
//addSubview(label)





//let aFont = UIFont(name: "Optima-Bold", size: radius/5)
//// create a dictionary of attributes to be applied to the string
//let attr:CFDictionaryRef = [NSFontAttributeName:aFont!,NSForegroundColorAttributeName:UIColor.whiteColor()]
//// create the attributed string
//let text = CFAttributedStringCreate(nil, p.index.description, attr)
//// create the line of text
//let line = CTLineCreateWithAttributedString(text)
//// retrieve the bounds of the text
//let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.UseOpticalBounds)
//// set the line width to stroke the text with
//CGContextSetLineWidth(ctx, 1.5)
//// set the drawing mode to stroke
//CGContextSetTextDrawingMode(ctx, kCGTextStroke)
//// Set text position and draw the line into the graphics context, text length and height is adjusted for
//let xn = p.element.x - bounds.width/2
//let yn = p.element.y - bounds.midY
//CGContextSetTextPosition(ctx, xn, yn)
//// the line of text is drawn - see https://developer.apple.com/library/ios/DOCUMENTATION/StringsTextFonts/Conceptual/CoreText_Programming/LayoutOperations/LayoutOperations.html
//// draw the line of text
//CTLineDraw(line, ctx)
