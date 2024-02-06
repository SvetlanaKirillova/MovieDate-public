//
//  MovieViewModel.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 16.09.2023.
//

import Foundation

protocol MoviesUploadViewDelegate {
    func didCurrentMovieUpload(currentMovie: MovieModel)
}

class MoviesMatchPresenter {
    
    private var movies = [MovieModel]()
    private var movieIndex: Int = 0
    private let userDataServise = UserDataService()
    private var movieServiceManager = MovieDataService()
    var currentMovieDelegate: MoviesUploadViewDelegate?
    
    var currentUser: User?
    var partner: User?
    
    init() {
        movieServiceManager.delegate = self
    }
    
    var moviesCount: Int {
        return movies.count
    }
    
    var isCurrentIndexGood: Bool {
        if movieIndex < movies.count {
            return true
        }
        return false
    }
    
    var currentMovieId: Int {
        return movies[self.movieIndex].id
    }
    
    func addMovies(_ newBunch: [MovieModel]){
        movies.append(contentsOf: newBunch)
    }
    
    func parnterAdded(_ partner: User){
        userDataServise.delegate = self
        userDataServise.subscribeOnUserUpdates(login: partner.login)
    }
    
    func likedCurrentMovie(){
        currentUser?.matchMovieIds.insert(currentMovieId)
        if let partner = partner {
            if partner.matchMovieIds.contains(currentMovieId){
                print("We have the match!")
            }
        }
    }
    
    private func passCurrentMovieToView() {
        if isCurrentIndexGood {
            currentMovieDelegate?.didCurrentMovieUpload(currentMovie: movies[movieIndex])
            movieIndex += 1
        }
    }
    
    func getMovieToShow(){
        if movies.count == 0 || !isCurrentIndexGood {
            print("Asking movie service for movies...")
            movieServiceManager.fetchNextPageOfMovies()
        } else {
            passCurrentMovieToView()
        }
    }

}

extension MoviesMatchPresenter: UserDataDelegate {
    
    func didUserUpdate(moviesIds: [Int]) {
        
        partner?.matchMovieIds = Set(moviesIds)
        if let currentUser = currentUser {
            if currentUser.matchMovieIds == partner?.matchMovieIds {
                print("we have a match!")
            }
        }
    }
}

extension MoviesMatchPresenter: MovieDataDelegate {
    func didLoadMovies(_ movieService: MovieDataService, movies: [MovieModel]) {
        print("Movies are uploaded...Passing it to the VC")
        self.movies = movies
        passCurrentMovieToView()
    }
    
    func didFailWithError(_ error: Error) {
        print("Error ccurs during fetching movies data: \(error)")
    }
    
    
}
