//
//  LoginVC.swift
//  rndm
//
//  Created by Ivan Toskov on 19.09.18.
//  Copyright © 2018 Ivan Toskov. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = emailTxt.text,
            let password = passwordTxt.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func createUserBtnPressed(_ sender: Any) {
    }
}
