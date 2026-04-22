//
//  UIComponents.swift
//  DormMarket
//
//  Created by kubmakk on 04.04.2026.
//

import Foundation
import UIKit
import SnapKit

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


final class DormTableCell: UITableViewCell {
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    func configure(with name: String) {
        title.text = name
    }
}
