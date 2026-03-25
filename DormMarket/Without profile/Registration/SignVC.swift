//
//  SignVC.swift
//  DormMarket
//
//  Created by kubmakk on 14.03.2026.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
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
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.keyboardType = .emailAddress
        field.borderStyle = .roundedRect
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        return field
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
    
    private let confirmPassField: UITextField = {
        let field = UITextField()
        field.placeholder = "Confirm your password"
        field.borderStyle = .roundedRect
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(SignTouched), for: .touchUpInside)
        return button
    }()
    
    private lazy var logButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(LogTouched), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Регистрация"
        setupView()
        setupUI()
    }
    
    //MARK: - Functions
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(dormLogo,emailField, loginField, passwordField,confirmPassField, signButton, logButton)
    }
    
    private func setupUI() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.keyboardDismissMode = .onDrag
        
        loginField.delegate = self
        passwordField.delegate = self
        passwordField.delegate = self
        confirmPassField.delegate = self
        
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
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(dormLogo.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        loginField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        confirmPassField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPassField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        logButton.snp.makeConstraints { make in
            make.top.equalTo(signButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    //MARK: - Actions
    @objc private func SignTouched() {
        print("SignUp button tapped email: \(emailField.text), login: \(loginField.text) password: \(passwordField.text) confirm \(confirmPassField.text)")
        
        coordinator?.showProfile()
        
    }
    
    @objc private func LogTouched() {
        HapticVibro.vibrate(style: .rigid)
        coordinator?.showLoginVC()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = insets
            scrollView.verticalScrollIndicatorInsets = insets

            DispatchQueue.main.async {
                self.scrollView.scrollRectToVisible(self.logButton.frame, animated: true)
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

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            loginField.becomeFirstResponder()
        } else if textField == loginField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            confirmPassField.becomeFirstResponder()
        } else if textField == confirmPassField {
            textField.resignFirstResponder()
            SignTouched()
        }
        return true
    }
}
