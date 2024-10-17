//
//  UILabel.swift
//  iTunesTestTask
//
//  Created by Никита Козловский on 17.10.2024.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont) {
        self.init()
        
        self.text = text
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
