//
//  MovieModel.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 11.09.2023.
//

import Foundation

struct MovieModel {
    let id: Int
    let title: String
    let poster_url: String
    let genres: [GenreModel]
    
    init(id: Int, title: String, poster_url: String) {
        self.id = id
        self.title = title
        self.poster_url = poster_url
        genres = Array()
    }
    
    init(id: Int, title: String, poster_url: String, genres: [GenreModel]){
        self.id = id
        self.title = title
        self.poster_url = poster_url
        self.genres = genres
    }
    
}
