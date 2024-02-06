//
//  User.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 20.09.2023.
//

import Foundation

class User {
    var login: String
    var password: String?
    var matchMovieIds = Set<Int>()
    var parnter: User?
    
    init(login: String){
        self.login = login
    }
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}

