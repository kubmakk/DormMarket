//
//  UIComponents.swift
//  DormMarket
//
//  Created by kubmakk on 04.04.2026.
//

import Foundation
import UIKit

extension UIButton.Configuration {
    static func dormMarketCapsule(systemName: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        config.imagePadding = 8
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        return config
    }
}
