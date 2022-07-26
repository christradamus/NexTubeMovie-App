//
//  DetailRouter.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import UIKit

class DetailRouter{
    var viewController: UIViewController{
        return createViewControllet()
    }
    
    var movieID: String?
    
    private var sourceView: UIViewController?
    
    init(movieID: String? = ""){
        self.movieID = movieID
    }

    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        
        self.sourceView = view
    }
    
    private func createViewControllet() -> UIViewController{
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.movieID = self.movieID
        return view
    }
}

    

