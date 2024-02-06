//
//  MovieMatchViewController.swift
//  MovieDate
//
//  Created by Svetlana Kirillova on 12.09.2023.
//

import UIKit
import SDWebImage

enum SwipeDirection {
    case lefty
    case righty
}

class MovieMatchViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var tmpPosterView: UIImageView!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    var movieMatchPresenter = MoviesMatchPresenter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieMatchPresenter.currentMovieDelegate = self
        movieMatchPresenter.getMovieToShow()
    }
    
    
    @IBAction func movieSwiped(_ sender: UISwipeGestureRecognizer) {
        
        userMadeChoice(sender.direction == .left ? .lefty: .righty)
    }

    @IBAction func yesNoButtonTapped(_ sender: UIButton) {
        
        guard let chosenLabel = sender.titleLabel else {
            fatalError("Button \(sender) does not have a title.")
        }
        
        userMadeChoice(chosenLabel.text == K.noButtonName ? .lefty: .righty )
        
    }
    
    
    func userMadeChoice(_ direction: SwipeDirection){
        animateSwiping(to: direction)
        
        if direction == .righty {
            movieMatchPresenter.likedCurrentMovie()
        }
        movieMatchPresenter.getMovieToShow()

    }
    
    func animateSwiping(to direction: SwipeDirection){
        
        tmpPosterView.isHidden = false
        tmpPosterView.image = posterImageView.image
        posterImageView.image = nil
        movieTitleLabel.text = ""
        UIView.animate(withDuration: 0.4) {
            self.moveTmpPoster(to: direction)
            
        } completion: { done in
            self.tmpPosterView.isHidden = true
            self.moveTmpPoster(to: nil)
            
        }
    }

    
    func moveTmpPoster(to direction: SwipeDirection?){

        let width = self.tmpPosterView.frame.width
        let height = self.tmpPosterView.frame.height
        
        switch direction{
        case .lefty:
            tmpPosterView.center = CGPoint(x: tmpPosterView.center.x - width ,
                                           y: tmpPosterView.center.y + height/2)
        case .righty:
            tmpPosterView.center = CGPoint(x: tmpPosterView.center.x + width ,
                                           y: tmpPosterView.center.y + height/2)
        default:
            tmpPosterView.center = posterImageView.center
        }
        
    }
    
    
    func animateYesNoButtons(swiped swipe: SwipeDirection){
        
        switch swipe {
        case .lefty:
            UIView.animate(withDuration: 0.2) {
                self.noButton.layer.opacity = 0
            } completion: { done in
                self.noButton.layer.opacity = 1
            }
        case .righty:
            UIView.animate(withDuration: 0.2) {
                self.yesButton.layer.opacity = 0
                
            } completion: { done in
                self.yesButton.layer.opacity = 1
            }
        }
    }
    
    
    func showNextPoster(to movie: MovieModel){
        print("Showing movie \(movie.title)")
 
        DispatchQueue.main.async {

            let imageUrl = URL(string: S.imagetmdbUrl + movie.poster_url)
            
            UIView.animate(withDuration: 2) {
                self.posterImageView.sd_setImage(with: imageUrl)
                self.movieTitleLabel.text = movie.title
            } completion: { done in
                
            }
        }

//        else {
//            showLoadingImage()
//        }

    }
    
    
    func showLoadingImage(){
        posterImageView.image = UIImage(named: K.loadingImageFileName)
    }
    
}

extension MovieMatchViewController: MoviesUploadViewDelegate {
    func didCurrentMovieUpload(currentMovie: MovieModel) {
        showNextPoster(to: currentMovie)
    }
    
    
}





