//
//  ProfileVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(logoutButton)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        logoutButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        logoutButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }
        
    @objc private func buttonTapped(){
        print("Кнопка нажата")
    }
}
