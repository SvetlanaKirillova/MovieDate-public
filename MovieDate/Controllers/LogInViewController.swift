//
//  StartPageViewController.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 19.09.2023.
//

import UIKit
import FirebaseFirestore

class LogInViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        errorLabel.isHidden = true
        loginPresenter.loginViewDelegate = self
    }
    

    @IBAction func signInPressed(_ sender: UIButton) {
        if let login = loginTextField.text, let password = passwordTextField.text{

            loginPresenter.loginWithCredentials(login: login, password: password)

        } else {
            showError(message: "Login/password cannot empty.")
        }
    }
    
    func showError(message: String){
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueLoginToMain {
            if let login = loginTextField.text, let password = passwordTextField.text {
                let currentUser = User(login: login, password: password)
                if let destinationController = segue.destination as? MovieMatchViewController {
                
                    destinationController.movieMatchPresenter.currentUser = currentUser
                }
            }
        }
    }
}

// MARK: - LoginUser View Delegate Methods

extension LogInViewController: LoginUserViewDelegate {
    func didUserLoggedIn(withLogin login: String, password: String) {
        let defaults = UserDefaults.standard
        defaults.set(login, forKey: "login")
        defaults.set(password, forKey: "password")
        self.performSegue(withIdentifier: K.segueLoginToMain , sender: self)
    }
    
}

// MARK: - UITextField Delegate Methods

extension LogInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            errorLabel.isHidden = true
        } else {
            showError(message: "Login/password cannot empty")
        }
    }
}
