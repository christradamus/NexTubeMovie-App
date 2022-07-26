//
//  DetailView.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import UIKit
import RxSwift

class DetailView: UIViewController {

    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var descriptionMovie: UILabel!
    @IBOutlet private weak var originalTitle: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    
    var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.red
        getDataAndShowDetailMovie()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
    }
    
    private func getDataAndShowDetailMovie(){
        guard let idMovie = movieID else {return}
        
        return viewModel.getMovieData(movieID: idMovie).subscribe(
            onNext: { movie in
                self.showMovieData(movie: movie)
            }, onError: { error in
                print("Ha ocurrido un error: \(error)")
            }, onCompleted: {
            }).disposed(by: disposeBag)

    }
    func showMovieData(movie: MovieDetail){
        DispatchQueue.main.async {
            self.titleHeader.text = movie.title
            self.imageFilm.imageFromServerUrl(urlString: Constants.URL.urlImages+movie.posterPath, placeholderImage: UIImage(named: "cine")!)
            self.descriptionMovie.text = movie.overview
            self.releaseDate.text = movie.releaseDate
            self.originalTitle.text = movie.originalTitle
            self.voteAverage.text = String(movie.voteAverage)
        }
    }

}
