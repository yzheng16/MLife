//
//  UserProfileController.swift
//  MLife
//
//  Created by Yi Zheng on 2018-06-28.
//  Copyright © 2018 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleGearButton))
        fetchUser()
    }
    
    @objc func handleGearButton(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let loginController = LoginController()
        let navLoginController = UINavigationController(rootViewController: loginController)
        if Auth.auth().currentUser != nil{
            alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
                do{
                    try Auth.auth().signOut()
                    self.present(navLoginController, animated: true, completion: nil)
                }catch let error{
                    print("failed to sign out:\n", error)
                }
                
            }))
        }else {
            alertController.addAction(UIAlertAction(title: "Log In", style: .default, handler: { (_) in
                self.present(navLoginController, animated: true, completion: nil)
            }))
        }
        
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func fetchUser(){
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary = snapshot.value as?[String:Any] else {return}
                self.navigationItem.title = dictionary["username"] as? String
            }
        }else {
            navigationItem.title = "Please Log In"
        }
    }
}
