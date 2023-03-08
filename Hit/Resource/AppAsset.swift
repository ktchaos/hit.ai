//
//  AppAsset.swift
//  Hit
//
//  Created by Catarina Serrano on 07/03/23.
//

import UIKit

enum AppAsset: String {
    case plus
    case menu = "filemenu.and.cursorarrow"
    case paperPlane = "paperplane.fill"

    var image: UIImage {
        return UIImage(systemName: self.rawValue) ?? .checkmark
    }
}
