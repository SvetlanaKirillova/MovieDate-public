//
//  RegistrationViewController.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 19.09.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if let login = loginTextField.text, let password = passwordTextField.text {
            
            createUserIfCorrected(login: login, password: password)

        }
    }
    
    func createUserIfCorrected(login: String, password: String) {
        if login == "" {
            errorLabel.isHidden = false
            errorLabel.text = "Login cannot be empty"
            return
        }
        if password == "" {
            errorLabel.isHidden = false
            errorLabel.text = "Password cannot be empty"
            return
        }
        
        db.collection("md_user").getDocuments{ query, error in
            if let error = error {
                print(error)
            } else if let query = query {
                if query.documents.filter({ $0.documentID == login }).count != 0 {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "User with such login already exist. Please choose another one."
                } else{
                    self.createNewUser(login: login, password: password)
                    self.performSegue(withIdentifier: K.segueRegistrationToMain, sender: self)
                }
            }
        }
    }
    
    func createNewUser(login: String, password: String){
        
        db.collection("md_user").document(login).setData([
            "password": password,
            "matchMovieId" : 0
        ]) { err in
            if let error = err {
                print("Error occurs during signing up: \(error)")
            } else {
                print("User created!")
            }
        }
    }
}
