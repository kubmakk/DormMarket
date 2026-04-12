//
//  ExtensionUIView.swift
//  DormMarket
//
//  Created by kubmakk on 14.03.2026.
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for index in subviews {
            self.addSubview(index)
        }
    }
}
