//
//  HomeRouter.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

//creacion de home y router
import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController{
        return createViewControllet()
    }

    private var sourceView: UIViewController?
    
    private func createViewControllet() -> UIViewController{
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        
        self.sourceView = view
    }
    
    func navigateToDetailView(movieID: String) {
        let detailView = DetailRouter(movieID: movieID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
