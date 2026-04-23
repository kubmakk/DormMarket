//
//  UIComponents.swift
//  DormMarket
//
//  Created by kubmakk on 04.04.2026.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

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
    
    private var userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.backgroundColor = .systemGray6
        return image
    }()
    
    private var userId: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private var centerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.backgroundColor = .systemRed
        image.clipsToBounds = true
        return image
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    private var bodyText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
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
        contentView.addSubview(userImage)
        contentView.addSubview(userId)
        contentView.addSubview(centerImage)
        contentView.addSubview(title)
        contentView.addSubview(bodyText)
        
        userImage.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        userId.snp.makeConstraints{ make in
            make.centerY.equalTo(userImage.snp.centerY)
            make.left.equalTo(userImage.snp.right).offset(12)
            make.right.equalToSuperview().inset(16)
        }
        
        centerImage.snp.makeConstraints{ make in
            make.top.equalTo(userImage.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(centerImage.snp.width).multipliedBy(0.75)
        }
        
        title.snp.makeConstraints{ make in
            make.top.equalTo(centerImage.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        
        bodyText.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    func configure(with userId: Int, title: String, bodyText: String, imageCenter: String?, imageAvatar: String?, isDark: Bool) {
        self.userId.text = "ID: \(userId)"
        self.title.text = title
        self.bodyText.text = bodyText
        
        let textColor: UIColor = isDark ? .white : .black
            self.userId.textColor = textColor
            self.title.textColor = textColor
            self.bodyText.textColor = textColor
            
            self.backgroundColor = isDark ? .black : .white
        
        let placeholder = UIImage(systemName: "person.circle")
        
        self.userImage.kf.cancelDownloadTask()
        self.centerImage.kf.cancelDownloadTask()
        
        self.userImage.image = placeholder
        self.centerImage.image = nil
        
        if let urlString = imageAvatar, let url = URL(string: urlString) {
            self.userImage.kf.setImage(with: url, placeholder: placeholder, options: [.cacheOriginalImage, .transition(.fade(0.2))])
        }
        
        if let urlString = imageCenter, let url = URL(string: urlString) {
            self.centerImage.kf.setImage(with: url, options: [.cacheOriginalImage, .transition(.fade(0.2))])
        }
    }
}


