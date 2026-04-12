////
////  LoginVC.swift
////  DormMarket
////
////  Created by kubmakk on 18/2/26.
////
// import UIKit
// import SnapKit
//
// class LoginViewController: ViewController{
//    
//    //MARK: - Visual Content
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        return scrollView
//    }()
//    
//    private lazy var contentView: UIView = {
//        let view = UIView()
//        return view
//    }()
//    
//    private let dormLogo: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "DormMarket")
//        return imageView
//    }()
//    
//    private let loginField: UITextField = {
//        let field = UITextField()
//        field.placeholder = "Log in"
//        field.returnKeyType = .next
//        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//        field.leftViewMode = .always
//        field.rightViewMode = .always
//        field.clearButtonMode = .whileEditing
//        field.borderStyle = .roundedRect
//        return field
//    }()
//    
//    private let passwordField: UITextField = {
//        let field = UITextField()
//        field.placeholder = "Password"
//        field.returnKeyType = .done
//        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//        field.leftViewMode = .always
//        field.rightViewMode = .always
//        field.clearButtonMode = .whileEditing
//        field.isSecureTextEntry = true
//        field.borderStyle = .roundedRect
//        return field
//    }()
//    
//    private lazy var LoginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Login", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = .blue
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(LoginTouched), for: .touchUpInside)
//        return button
//    }()
//    
//    
//    //MARK: - View
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupUI()
//        addBananas()
//        addEggplants()
//        addSwaston()
//    }
//    
//    //MARK: - Functions
//    func setupView(){
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubviews(dormLogo, LoginButton, loginField, passwordField)
//    }
//    
//    func setupUI(){
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalToSuperview()
//        }
//        
//        dormLogo.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(60)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(120)
//        }
//        
//        loginField.snp.makeConstraints { make in
//            make.top.equalTo(dormLogo.snp.bottom).offset(40)
//            make.left.right.equalToSuperview().inset(30)
//            make.height.equalTo(45)
//        }
//        
//        passwordField.snp.makeConstraints { make in
//            make.top.equalTo(loginField.snp.bottom).offset(15)
//            make.left.right.equalToSuperview().inset(30)
//            make.height.equalTo(45)
//        }
//        
//        LoginButton.snp.makeConstraints { make in
//            make.top.equalTo(passwordField.snp.bottom).offset(30)
//            make.left.right.equalToSuperview().inset(30)
//            make.height.equalTo(50)
//            make.bottom.equalToSuperview().inset(50)
//        }
//    }
//    
//    private func addBananas() {
//        for _ in 1...20 {
//            let label = UILabel()
//            label.text = "🍌"
//            label.font = .systemFont(ofSize: CGFloat.random(in: 20...50))
//            contentView.addSubview(label)
//            
//            let randomX = Int.random(in: 0...Int(UIScreen.main.bounds.width - 50))
//            let randomY = Int.random(in: 0...Int(UIScreen.main.bounds.height))
//            
//            label.snp.makeConstraints { make in
//                make.left.equalToSuperview().offset(randomX)
//                make.top.equalToSuperview().offset(randomY)
//            }
//        }
//    }
//
//    private func addEggplants() {
//        for _ in 1...20 {
//            let label = UILabel()
//            label.text = "🍆"
//            label.font = .systemFont(ofSize: CGFloat.random(in: 20...50))
//            contentView.addSubview(label)
//            
//            let randomX = Int.random(in: 0...Int(UIScreen.main.bounds.width - 50))
//            let randomY = Int.random(in: 0...Int(UIScreen.main.bounds.height))
//            
//            label.snp.makeConstraints { make in
//                make.left.equalToSuperview().offset(randomX)
//                make.top.equalToSuperview().offset(randomY)
//            }
//        }
//    }
//    
//    private func addSwaston() {
//        for _ in 1...20 {
//            let label = UILabel()
//            label.text = "卐"
//            label.font = .systemFont(ofSize: CGFloat.random(in: 20...50))
//            contentView.addSubview(label)
//            
//            let randomX = Int.random(in: 0...Int(UIScreen.main.bounds.width - 50))
//            let randomY = Int.random(in: 0...Int(UIScreen.main.bounds.height))
//            
//            label.snp.makeConstraints { make in
//                make.left.equalToSuperview().offset(randomX)
//                make.top.equalToSuperview().offset(randomY)
//            }
//        }
//    }
//    
//    //MARK: - objc functions
//    @objc func LoginTouched(){
//        print("fdkljkadshjfdsasdaiuf")
//    }
//
// }
