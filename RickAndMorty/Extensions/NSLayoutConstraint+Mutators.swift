//
//  NSLayoutConstraint+Mutators.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 14.09.2023.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func with(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(Float(value))
    }
}

