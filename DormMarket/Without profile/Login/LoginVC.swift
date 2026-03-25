//
//  LoginVC.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    //MARK: - Visual Content
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dormLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(named: "DormMarket")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let loginField: UITextField = {
        let field = UITextField()
        field.placeholder = "Log in"
        field.borderStyle = .roundedRect
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(LoginTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(RegTouched), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Вход"
        setupView()
        setupUI()
    }
    
    //MARK: - Functions
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(dormLogo, loginField, passwordField, loginButton, signButton)
    }
    
    private func setupUI() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.keyboardDismissMode = .onDrag
        
        loginField.delegate = self
        passwordField.delegate = self
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        dormLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        loginField.snp.makeConstraints { make in
            make.top.equalTo(dormLogo.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        signButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    //MARK: - Actions
    @objc private func LoginTouched() {
        HapticVibro.vibrate(style: .rigid)
        coordinator?.showProfile()
    }
    
    
    @objc private func RegTouched() {
        HapticVibro.vibrate(style: .rigid)
        coordinator?.showSignUpVC()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = insets
            scrollView.verticalScrollIndicatorInsets = insets

            DispatchQueue.main.async {
                self.scrollView.scrollRectToVisible(self.signButton.frame, animated: true)
            }
        }
        
        @objc private func keyboardWillHide(notification: NSNotification) {
            scrollView.contentInset = .zero
            scrollView.verticalScrollIndicatorInsets = .zero
        }
    
    // MARK: - View Lifecycle
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self)
        }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            textField.resignFirstResponder()
            LoginTouched()
        }
        return true
    }
}
