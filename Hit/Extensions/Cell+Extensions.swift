//
//  Cell+Extensions.swift
//  Hit
//
//  Created by Catarina Serrano on 10/03/23.
//

import Foundation
import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        String(describing: self)
    }
}
