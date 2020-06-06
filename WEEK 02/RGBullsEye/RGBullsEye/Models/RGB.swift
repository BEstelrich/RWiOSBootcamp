/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
import Foundation
import UIKit


extension UIColor {
  
  convenience init(rgb: RGB) {
    let red = CGFloat(rgb.red) / 255.0
    let green = CGFloat(rgb.green) / 255.0
    let blue = CGFloat(rgb.blue) / 255.0
    self.init(red: red, green: green, blue: blue, alpha:1.0)
  }
  
}


struct RGB {
  
  var red = 127
  var green = 127
  var blue = 127
  
  
  func difference(target: RGB) -> Double {
    let redDifference = Double(red - target.red)
    let greenDifference = Double(green - target.green)
    let blueDifference = Double(blue - target.blue)
    return sqrt(redDifference * redDifference + greenDifference * greenDifference + blueDifference * blueDifference) / 255.0
  }
  
}
