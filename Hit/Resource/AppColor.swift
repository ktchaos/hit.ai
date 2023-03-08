//
//  AppColor.swift
//  Hit
//
//  Created by Catarina Serrano on 06/03/23.
//

import Foundation
import UIKit

enum AppColor: String {
    case darkerGray
    case lightGray
    case darkestGray

    var color: UIColor {
        return UIColor(named: self.rawValue) ?? .black
    }
}
