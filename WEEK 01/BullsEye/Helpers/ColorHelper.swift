// 2020.05.31 | BullsEye - ColorSystemHelper.swift | Copyright © 2020 BEstelrich. All rights reserved.
import UIKit


class ColorHelper {
  
  private static func convertValueToRGB(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 255
    return convertedValue
  }
  
  
  private static func convertValueToHue(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 360
    return convertedValue
  }
  
  
  private static func convertValueToSaturation(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 100
    return convertedValue
  }
  
  
  private static func convertValueToBrightness(_ value: Float) -> CGFloat {
    let roundedValue = CGFloat(value.rounded())
    let convertedValue = roundedValue / 100
    return convertedValue
  }
  
  
  static func createRGB(red redValue: Float,
                        green greenValue: Float,
                        blue blueValue: Float) -> UIColor {
    let userSelectedColor = UIColor(red: convertValueToRGB(redValue),
                                    green: convertValueToRGB(greenValue),
                                    blue: convertValueToRGB(blueValue),
                                    alpha: 1.0)
    return userSelectedColor
  }
  
  
  static func createHSB(hue hueValue: Float,
                        saturation saturationValue: Float,
                        brightness brightnessValue: Float) -> UIColor {
    let userSelectedColor = UIColor(hue: convertValueToHue(hueValue),
                                    saturation: convertValueToSaturation(saturationValue),
                                    brightness: convertValueToBrightness(brightnessValue),
                                    alpha: 1.0)
    return userSelectedColor
  }
  
}
