//
//  LogInController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-06-28.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let emaileTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    @objc func handleInput(){
        let isTextFieldValied = emaileTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 >= 6
        if isTextFieldValied {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(r: 99, g: 149, b: 224)
        }else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        }
    }
    
    let loginButton: UIButton = {
        let b = UIButton()
        b.isEnabled = false
        b.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        b.layer.cornerRadius = 3
        b.setTitle("Log In", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return b
    }()
    
    @objc func handleLogin(){
        guard let email = emaileTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to login:\n", err)
                return
            }
            print("Successed to login:\n", user?.user.uid ?? "")
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
            mainTabBarController.setupTabBarController()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let dontHaveAccount: UIButton = {
        let b = UIButton()
        let attributedText = NSMutableAttributedString(string: "Don't have account?  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedText.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.foregroundColor: UIColor(r: 99, g: 149, b: 224)]))
        
        b.setAttributedTitle(attributedText, for: .normal)
        b.addTarget(self, action: #selector(handleShowSignupPage), for: .touchUpInside)
        return b
    }()
    
    @objc func handleShowSignupPage(){
        let signupController = SignUpController()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupStackView()
        
        view.addSubview(dontHaveAccount)
        dontHaveAccount.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupStackView(){
        let loginStackView = UIStackView(arrangedSubviews: [emaileTextField, passwordTextField, loginButton])
        loginStackView.distribution = .fillEqually
        loginStackView.axis = .vertical
        loginStackView.spacing = 10
        
        view.addSubview(loginStackView)
        
        loginStackView.anchorCenterYToSuperview()
        loginStackView.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
    }
}
