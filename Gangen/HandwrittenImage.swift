//
//  HandwrittenImage.swift
//  SceneDetector
//
//  Created by Yasunori Tanaka on 2017/11/14.
//  Copyright © 2017 Yasunori Tanaka. All rights reserved.
//

import UIKit
import CoreML
import Vision

@IBDesignable
class HandwrittenImage: UIView {
  
  @IBInspectable var weight: Double = 1.0 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  private struct Constants {
    static let plusLineWidth: CGFloat = 10.0
    //static let plusButtonScale: CGFloat = 0.6
    //static let halfPointShift: CGFloat = 0.5
  }
  
  private var halfWidth: CGFloat {
    return bounds.width / 2
  }
  
  private var halfHeight: CGFloat {
    return bounds.height / 2
  }
  
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    // Drawing code
    //let path = UIBezierPath(ovalIn: rect)
    UIColor.blue.setFill()
    UIRectFill(rect)
    //path.fill()
    
    //set up the width and height variables
    //for the horizontal stroke
    //let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
    //let halfPlusWidth = plusWidth / 2

//    let context = UIGraphicsGetCurrentContext()
    //UIColor(white: CGFloat(0), alpha: CGFloat(1)).setStroke()
    
    let m = gan()
    func random() -> Double {
      return Double(arc4random()) / 0xFFFFFFFF
    }
    
    //let ganInput = Array(repeating: 0.0, count: 100)
    guard let ganInput = try? MLMultiArray(shape:[100], dataType:MLMultiArrayDataType.double) else {
      fatalError("Unexpected runtime error. MLMultiArray")
    }
    for i in 0...99 {
      ganInput[i] = NSNumber(floatLiteral:random())
      NSLog("random, %f", ganInput[i].floatValue)
    }

    guard let out = try? m.prediction(input: ganInput) else {
      fatalError("Unexpected runtime error. MLMultiArray")
    }
    
    for i  in 0...27 {
      for j in 0...27 {
        let index: [NSNumber] = [0 as NSNumber, i as NSNumber, j as NSNumber]
        //NSLog("generated array, %d", out.gan_out[[1, 0, 0]])
        let value = (out.output[index].floatValue * 0.5) + 0.5
        //print(value, terminator:" ")
      }
      //print("\n")
    }

    let HIGHT = 27
    let WIDTH = 27

    for i in 0...HIGHT {
      for j in 0...WIDTH {
        
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.plusLineWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
          x: CGFloat(j * 10),
          y: CGFloat(i * 10) + Constants.plusLineWidth / 2
        ))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
          x: CGFloat((j * 10) + 10),
          y: CGFloat(i * 10) + Constants.plusLineWidth / 2
        ))
        
        //set the stroke color
        // TODO set grayscale color from the generator
        //UIColor(white: CGFloat((1/Double(WIDTH)) * Double(j) * weight), alpha: CGFloat(1)).setStroke()
        let index: [NSNumber] = [0 as NSNumber, i as NSNumber, j as NSNumber]
        UIColor(white: CGFloat(truncating: out.output[index]), alpha: CGFloat(1)).setStroke()
        
        //draw the stroke
        plusPath.stroke()
        //        context?.addPath(plusPath.cgPath)
      }
      
    }
    
  }
    
}
