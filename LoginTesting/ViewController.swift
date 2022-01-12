//
//  ViewController.swift
//  LoginTesting
//
//  Created by Jason bartley on 1/11/22.
//

import UIKit

enum signInError: LocalizedError {
    case wrongUserNameOrPassword
    case invalidField
    case passwordTooShort
    case passwordTooLong
    case usernameTooShort
    case usernameTooLong
    
    var errorDesciption: String? {
        switch self {
        
        case .wrongUserNameOrPassword:
            return "Wrong email or password!"
        case .passwordTooShort:
            return "password too short!"
        case .passwordTooLong:
            return "password is too long!"
        case .usernameTooShort:
            return "username too short!"
        case .usernameTooLong:
            return "username too long!"
        case .invalidField:
            return "invalid fields!"
        }
    }
    
    var errorMessage: String? {
        switch self {
        
        case .wrongUserNameOrPassword:
            return nil
        case .passwordTooShort:
            return "Password must be longer than 8 characters."
        case .passwordTooLong:
            return "Password must be shorter than 20 characters."
        case .usernameTooShort:
            return "Username must be longer than 3 characters."
        case .usernameTooLong:
            return "username must be shorter than 20 characters."
        case .invalidField:
            return "invalid fields"
        }
    }
    
    
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    let passwordChecker = PasswordChecker()
    let usernameChecker = UsernameChecker()
    
    let database: [String: String] = {
        ["username": "jason",
         "password": "password123"]
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN IN"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let usernameField: LoginTextField = {
        let field = LoginTextField()
        field.placeholder = "username"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityValue = "enter email address here"
        field.accessibilityHint = "type in email address to sign in for pablos portal"
        return field
    }()
    
    private let passwordField: LoginTextField = {
        let field = LoginTextField()
        field.placeholder = "password"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.isAccessibilityElement = true
        field.accessibilityValue = "enter password here"
        return field
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign in", for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.isAccessibilityElement = true
        button.accessibilityValue = "tap here to sign in"
        button.accessibilityHint = "after typing in both email and password tap here to sign in"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInLabel.frame = CGRect(x: 25, y: view.safeAreaInsets.top + 10, width: view.width - 50, height: 50)
        usernameField.frame = CGRect(x: 25, y: signInLabel.bottom + 10, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x:25, y: usernameField.bottom+10, width: view.width-50, height: 50)
        signInButton.frame = CGRect(x:35, y: passwordField.bottom+20, width: view.width-70, height: 50)
    }
    
    
    private func initialSetUp() {
        view.backgroundColor = .black
        title = "SIGN IN"
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signInLabel)
       
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        
        return true
    }
    
    @objc func didTapSignUp() {
       //do nothing
    }
    
    @objc func didTapSignIn() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        //makes sure fields have valid input
        do {
            let username = try usernameChecker.checkUsername(usernameField.text)
            let password = try passwordChecker.checkPassword(passwordField.text)
            
            guard database["username"] == username else { throw signInError.wrongUserNameOrPassword }
            guard database["password"] == password else { throw signInError.wrongUserNameOrPassword}
            
            let ac = UIAlertController(title: "signed in!", message: "welcome \(username)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel))
            present(ac, animated: true, completion: nil)
            
        } catch {
            showSignInError(error as! signInError)
        }
        
    }
}

extension ViewController {
    func showSignInError(_ err: signInError) {
        let ac = UIAlertController(title: err.errorDesciption, message: err.errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .cancel))
        DispatchQueue.main.async {
            self.present(ac, animated: true)
        }
    }
}
