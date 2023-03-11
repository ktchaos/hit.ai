//
//  UIView+Extensions.swift
//  Hit
//
//  Created by Catarina Serrano on 11/03/23.
//

import UIKit

public extension UIView {
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .repeat, animations: {
            self.alpha = 1.0
        })
    }

    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .repeat, animations: {
            self.alpha = 0.0
        })
    }
}
