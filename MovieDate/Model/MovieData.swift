//
//  MovieData.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 11.09.2023.
//

import Foundation


struct MoviesRequestResult: Decodable {
    let page: Int
    let results: [MovieData]
    let total_pages: Int
    
}

struct MovieData: Decodable {
    
    let id: Int
    let title: String
    let vote_average: Float
    let poster_path: String
}
