//
//  DetailViewModel.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConecctions = ManagerConnectios()
    private(set) weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
        
    }
    func getMovieData(movieID: String) -> Observable<MovieDetail>{
        return managerConecctions.getDetailMovies(movieID: movieID)
    }
}

