//
//  UIStackView.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 14.10.2024.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
