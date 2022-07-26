//
//  HomeViewModel.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerConnections = ManagerConnectios()
    
    func bind(view: HomeView, router: HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
        
    }
    
    func gestListMoviesData() -> Observable<[Movie]>{
        return managerConnections.getPopularMovies()
    }
    
    func makeDetailView(movieID: String){
        router?.navigateToDetailView(movieID: movieID)
    }
}
