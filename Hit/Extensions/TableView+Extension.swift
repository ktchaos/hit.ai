//
//  TableView+Extension.swift
//  Hit
//
//  Created by Catarina Serrano on 08/03/23.
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

extension UITableView {
    func register(on identifiable: Identifiable.Type) {
        let identifier = identifiable.identifier
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<I: Identifiable>(on identifiable: I.Type, for indexPath: IndexPath) -> I? {
        return self.dequeueReusableCell(withIdentifier: I.identifier, for: indexPath) as? I
    }
}
