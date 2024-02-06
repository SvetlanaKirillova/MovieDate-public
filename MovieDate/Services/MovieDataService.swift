//
//  MovieManager.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 11.09.2023.
//

import Foundation
import SDWebImage
 

protocol MovieDataDelegate {
    func didLoadMovies(_ movieService: MovieDataService, movies: [MovieModel])
    func didFailWithError(_ error: Error)
}

class MovieDataService {
    
    var delegate: MovieDataDelegate?
    
    let headers = [
      "accept": "application/json",
      "Authorization": S.authUrl
    ]

    let baseUrl = S.moviedbBaseUrl
    
    var lastUploadedPage: Int = 0
    var totalPages: Int = 0
    
    
    func fetchMovies(lang: String = "en-US", page: String = "1"){
        let langParam = "language=\(lang)"
        let pageParam = "page=\(page)"
        let urlString = baseUrl+"&\(langParam)&\(pageParam)&sort_by=popularity.desc"
        print("Performing request with url \(urlString)")
        performRequest(withUrl: urlString)
    }
    
    func fetchNextPageOfMovies(){
        let nextPage = lastUploadedPage + 1
        if nextPage <= totalPages {
            fetchMovies(page: "\(nextPage)")
        } else {
            fetchMovies()
        }
        
    }
    
    func fetchGenres(){
        
    }
    
    func performRequest(withUrl urlString: String) {
        print(urlString)
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"

        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {

              if let safeData = data {
                  let movies = self.parseJSON(jsonData: safeData)
                  self.delegate?.didLoadMovies(self, movies: movies)
              }
              
          }
        })

        dataTask.resume()
    }
    
    func parseJSON(jsonData: Data) -> [MovieModel]{
        let decoder = JSONDecoder()
        var movies = [MovieModel]()
        
        do {
            let decodedData = try decoder.decode(MoviesRequestResult.self, from: jsonData)
            self.lastUploadedPage = decodedData.page
            self.totalPages = decodedData.total_pages
            decodedData.results.forEach({ movieDecoded in
                print("\(movieDecoded.id) - \(movieDecoded.title) - \(movieDecoded.vote_average)")
                
                let movie = MovieModel(
                    id: movieDecoded.id,
                    title: movieDecoded.title,
                    poster_url: movieDecoded.poster_path)
                
                movies.append(movie)
            })
        } catch {
            print("ERROR occurs during parsing JSON data: \(error)")
        }
        
        return movies
    }
}
