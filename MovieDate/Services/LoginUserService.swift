//
//  LoginUserService.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 25.09.2023.
//

import Foundation
import FirebaseFirestore

protocol LoginUserServiceDelegate{
    func didLoggedIn(login: String, password: String)
    func failedLoggedIn(error: LoginError)
}

struct LoginError: Error {
    var description: String
}

class LoginUserService {
    
    let db = Firestore.firestore()
    var loginDelegate: LoginUserServiceDelegate?
    
    func loginRequestWith(login: String, password: String){
        db.collection(S.FireStore.usersCollectionName).getDocuments { query, error in
            if let error = error {
                let loginError = LoginError(description: error.localizedDescription)
                self.loginDelegate?.failedLoggedIn(error: loginError)

            } else if let query = query {
                if let user = query.documents.first(where: {$0.documentID == login}){
                    if let userPass = user.data()[S.FireStore.fieldPassword] as? String {
                        if userPass == password {
                            self.loginDelegate?.didLoggedIn(login: login, password: password)
                        } else {
                            let incorrectPassError = LoginError(description: "Password is incorrect.")
                            self.loginDelegate?.failedLoggedIn(error: incorrectPassError)
                        }
                    }
                }
                
            }
        } 
    }
 
}
