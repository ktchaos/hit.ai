//
//  ViewModelBindable.swift
//  Hit
//
//  Created by Catarina Serrano on 04/03/23.
//

import Foundation
import UIKit

protocol ViewModelBindable: AnyObject {
    associatedtype ViewModelType

    var viewModel: ViewModelType? { get set }

    func bindViewModel()
}

extension ViewModelBindable where Self: UIViewController {
    func bind(to model: Self.ViewModelType) {
        self.viewModel = model
        self.loadViewIfNeeded()
        self.bindViewModel()
    }
}

extension ViewModelBindable where Self: UITableViewCell {
    func bind(to model: Self.ViewModelType) {
        self.viewModel = model
        self.bindViewModel()
    }
}

extension ViewModelBindable where Self: UICollectionViewCell {
    func bind(to model: Self.ViewModelType) {
        self.viewModel = model
        self.bindViewModel()
    }
}
