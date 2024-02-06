//
//  WelcomeViewController.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 02.10.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    let defaults = UserDefaults.standard
    var loginPresenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginPresenter.loginViewDelegate = self

        if let login = defaults.string(forKey: "login"), let password = defaults.string(forKey: "password") {
            loginPresenter.loginWithCredentials(login: login, password: password)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segueWelcomeToMain {
            if let login = defaults.string(forKey: "login"), let password = defaults.string(forKey: "password") {
                let currentUser = User(login: login, password: password)
                if let destinationController = segue.destination as? MovieMatchViewController {
                    destinationController.movieMatchPresenter.currentUser = currentUser
                }
            }
        }
    }
}

extension WelcomeViewController: LoginUserViewDelegate {
    func didUserLoggedIn(withLogin login: String, password: String) {
        performSegue(withIdentifier: K.segueWelcomeToMain, sender: self)
    }
}
