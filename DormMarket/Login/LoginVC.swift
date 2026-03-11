//
//  LoginVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit
import SnapKit

class LoginViewController: ViewController{
    
    private let buttonLogin: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let dormLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DormLogo")
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
