//
//  ViewCodable.swift
//  Hit
//
//  Created by Catarina Serrano on 04/03/23.
//

import UIKit

protocol ViewCodable {
    func setup()
    func setupSubviews()
    func setupConstraints()
    func setupExtraConfigurations()
}

extension ViewCodable {
    func setup() {
        self.setupSubviews()
        self.setupConstraints()
        self.setupExtraConfigurations()
    }

    func setupExtraConfigurations() {}
}
