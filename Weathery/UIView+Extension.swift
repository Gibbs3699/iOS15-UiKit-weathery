//
//  UIView+Extension.swift
//  Weathery
//
//  Created by TheGIZzz on 13/5/2565 BE.
//

import Foundation
import UIKit

extension UIView {
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
  }
}
