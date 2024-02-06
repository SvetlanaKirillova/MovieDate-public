////
////  MovieViewModelTests.swift
////  MovieDateTests
////
////  Created by Svetlana Kirillova on 16.09.2023.
////
//
//import XCTest
//@testable import MovieDate
//
//final class MovieViewModelTests: XCTestCase {
//    
//    var viewModel = MovieViewModel()
//    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        
//        let movie = MovieModel(id: 1, title: "Test Movie", poster_url: "some url")
//        viewModel.addMovies([movie])
//    }
//    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
//    func testIsIndexGood_True(){
//        
//        XCTAssertEqual(viewModel.isCurrentIndexGood, true)
//        
//    }
//    
//    func testIsIndexGood_False(){
//        
//        viewModel.prepareNextMovie()
//        
//        XCTAssertEqual(viewModel.isCurrentIndexGood, false)
//        
//    }
//    
//    func testPrepareNextMovie(){
//        
//        let movie2 = MovieModel(id: 1, title: "Test Movie2", poster_url: "some url2")
//        viewModel.addMovies([movie2])
//        
//        viewModel.prepareNextMovie()
//        
//        XCTAssertEqual(viewModel.getNextMovieTitle(), "Test Movie2")
//    }
//    
//    func testGetNextMoviePosterUrl_Ok(){
//        
//        XCTAssertEqual(viewModel.getMoviePosterUrl(), "some url")
//    }
//    
//    func testGetNextMoviePosterUrl_Nil(){
//        
//        viewModel.prepareNextMovie()
//        
//        XCTAssertNil(viewModel.getMoviePosterUrl())
//    }
//    
//    func testGetNextMovieTitle(){
//        
//        XCTAssertEqual(viewModel.getNextMovieTitle(), "Test Movie")
//    }
//    
//    func testGetNextMovieTitle_Nil(){
//        
//        viewModel.prepareNextMovie()
//        
//        XCTAssertEqual(viewModel.getNextMovieTitle(), nil)
//    }
//    
//    func testaddMovies(){
//        
//        XCTAssertEqual(viewModel.moviesCount, 1)
//    }
//    
//    func testCurrentIndex(){
//        XCTAssertEqual(viewModel.currentIndex, 0)
//    }
//}
