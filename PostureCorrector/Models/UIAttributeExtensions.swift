//
//  ColorPalette.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // Primary App Colors
    
    // BACKGROUND COLOR
    static let background = UIColor.colorWithRGB(rgbValue: 0x482C53)
    
    //lightest shade
    static let purple1 = UIColor.colorWithRGB(rgbValue: 0xF4EAF8)
    
    //second lightest
    static let purple2 = UIColor.colorWithRGB(rgbValue: 0xCEB8D6)
    
    //third lightest
    static let purple3 = UIColor.colorWithRGB(rgbValue: 0x94809D)
    
    //darkest purple
    static let purple4 = UIColor.colorWithRGB(rgbValue: 0x6E5677)
    
    static let redOverlay = UIColor.colorWithRGBAlpha(rgbValue: 0xFF4242)
    
}

public extension UIColor {
    /// Access the rgba values of this color
    var rgba: [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return [red, green, blue, alpha]
    }
    
    
    /// Initialize a color from an array of rgba
    ///
    /// - Parameter rgba: rgba values on scale of 0 to 1
    convenience init(_ rgba: [CGFloat]) {
        self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
    
    /// Gets a random color
    ///
    /// - Returns: random color
    static func randomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    /// Creates a color from a UInt as a hexvalue with the given alpha.
    ///
    /// - Parameters:
    ///   - rgbValue: color given as hexvalue
    ///   - alpha: alpha of the new color
    /// - Returns: new color
    class func colorWithRGB(rgbValue : UInt, alpha : CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func colorWithRGBAlpha(rgbValue : UInt, alpha : CGFloat = 0.3) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    /// Modulates the current UIColor and returns a new instance with modified values.
    ///
    /// - Parameters:
    ///   - hue: additional hue to provide
    ///   - additionalSaturation: additional saturation to provide
    ///   - additionalBrightness: additional brightness to provide
    /// - Returns: new Color
    func modified(withAdditionalHue hue: CGFloat, additionalSaturation: CGFloat, additionalBrightness: CGFloat) -> UIColor {
        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0
        
        if self.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return self
        }
    }
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

/// A Simple class to assist with UI Color theme
public class rgba: UIColor {
    
    /// Creates a new UIColor using rgba values on a scale of 0 to 255
    ///
    /// - Parameters:
    ///   - r: red on a scale from 0 to 255
    ///   - g: green on a scale from 0 to 255
    ///   - b: blue on a scale from 0 to 255
    ///   - a: alpha coeffiecient from 0 to 1
    /// - Returns: UIColor with the given rgba attributes
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r/255.00, green: g/255.00, blue: b/255.00, alpha: a)
    }
}
public class rgb: UIColor {
    
    /// Creates a new UIColor using rgb values on a scale of 0 to 255
    ///
    /// - Parameters:
    ///   - r: red on a scale from 0 to 255
    ///   - g: green on a scale from 0 to 255
    ///   - b: blue on a scale from 0 to 255
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r/255.00, green: g/255.00, blue: b/255.00, alpha: 1)
    }
}
