//
//  UserDBManager.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 23.09.2023.
//

import Foundation
import FirebaseFirestore

protocol UserDataDelegate {
    func didUserUpdate(moviesIds: [Int])
}

class UserDataService {
    private var db = Firestore.firestore()
    var delegate: UserDataDelegate?
    
    func subscribeOnUserUpdates(login: String){
        db.collection(K.FireStore.usersCollectionName)
            .document(login)
            .addSnapshotListener { documentSnapshot, error in
                if let error = error {
                    print(error)
                } else {
                    if let data = documentSnapshot?.data() {
                        if let likedIds = data[K.FireStore.fieldMoviesIds] as? [Int] {
                            self.delegate?.didUserUpdate(moviesIds: likedIds)
                            print(data)
                        }
                        
                    }
                }
            }
    }

}
