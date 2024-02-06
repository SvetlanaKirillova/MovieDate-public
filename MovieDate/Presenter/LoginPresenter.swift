//
//  LoginViewModel.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 23.09.2023.
//

import Foundation
//import FirebaseFirestore

protocol LoginUserViewDelegate {
    func didUserLoggedIn(withLogin login: String, password: String)
}

class LoginPresenter {
    
    let loginService = LoginUserService()
    var loginViewDelegate: LoginUserViewDelegate?

    init() {
        loginService.loginDelegate = self
    }
    
    func loginWithCredentials(login: String, password: String) {
        loginService.loginRequestWith(login: login, password: password)
    }
    
}

extension LoginPresenter: LoginUserServiceDelegate {
    
    func didLoggedIn(login: String, password: String) {
        self.loginViewDelegate?.didUserLoggedIn(withLogin: login, password: password)
    }
    
    func failedLoggedIn(error: LoginError) {
        print(error.description)
    }
    
}
