//
//  SignUpController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-06-28.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    let emaileTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
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
        let isTextFieldValied = emaileTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 >= 6
        if isTextFieldValied {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor(r: 99, g: 149, b: 224)
        }else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        }
    }
    
    let signupButton: UIButton = {
        let b = UIButton()
        b.isEnabled = false
        b.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        b.layer.cornerRadius = 3
        b.setTitle("Sign Up", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return b
    }()
    
    @objc func handleSignup(){
        guard let email = emaileTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user:\n", err)
                return
            }
            print("Successed to create user:\n", user?.user.uid ?? "")
            
            guard let username = self.usernameTextField.text else {return}
            guard let uid = user?.user.uid else {return}
            let dictionaryValues = ["username": username] as [String : Any]
            let values = [uid: dictionaryValues]
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, reference) in
                if let err = error {
                    print("Fail to save user info into db\n", err)
                    return
                }
                print("successfully save user info into db")
                
                guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                mainTabBarController.setupTabBarController()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    let alreadyHaveAccount: UIButton = {
        let b = UIButton()
        let attributedText = NSMutableAttributedString(string: "Already have account  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedText.append(NSAttributedString(string: "Log In", attributes: [NSAttributedStringKey.foregroundColor: UIColor(r: 99, g: 149, b: 224)]))
        
        b.setAttributedTitle(attributedText, for: .normal)
        b.addTarget(self, action: #selector(handleShowLoginPage), for: .touchUpInside)
        return b
    }()
    
    @objc func handleShowLoginPage(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupStackView()
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupStackView(){
        let signupStackView = UIStackView(arrangedSubviews: [emaileTextField, usernameTextField, passwordTextField, signupButton])
        signupStackView.distribution = .fillEqually
        signupStackView.axis = .vertical
        signupStackView.spacing = 10
        
        view.addSubview(signupStackView)
        
        signupStackView.anchorCenterYToSuperview()
        signupStackView.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
    }
}
