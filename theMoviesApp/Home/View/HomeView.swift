//
//  HomeView.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    private var filteresMovies = [Movie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .darkGray
        controller.searchBar.placeholder = "Buscar una pelicula"
        controller.searchBar.tintColor = UIColor.red
        
        return controller
        
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Atras", style: .plain, target: nil, action: nil)
       
        self.navigationItem.title = "NexTube Movies"

        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
        manageSearchBarController()
    }
    private func configureTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }
    
    private func getData(){
        return viewModel.gestListMoviesData()
            .subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                    self.movies = movies
                    self.reloadTableView()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)

        
    }
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
                
            
        }
    }
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { (result) in
                self.filteresMovies = self.movies.filter({ movie in
                    self.reloadTableView()
                    return movie.title.contains(result)
                })
               
            })
            .disposed(by: disposeBag)
    }
}

extension HomeView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteresMovies.count
        }
        else {
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomMovieCell.self)) as! CustomMovieCell
       
        if searchController.isActive && searchController.searchBar.text != "" {
        cell.imageMovie.imageFromServerUrl(urlString: "\(Constants.URL.urlImages+self.filteresMovies[indexPath.row].image)", placeholderImage: UIImage(named: "cine")!)
        cell.titleMovie.text = filteresMovies[indexPath.row].title
        cell.descriptionMovie.text = filteresMovies[indexPath.row].sinopsis
        }
        else {
            cell.imageMovie.imageFromServerUrl(urlString: "\(Constants.URL.urlImages+self.movies[indexPath.row].image)", placeholderImage: UIImage(named: "cine")!)
            cell.titleMovie.text = movies[indexPath.row].title
            cell.descriptionMovie.text = movies[indexPath.row].sinopsis
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.makeDetailView(movieID: String(self.filteresMovies[indexPath.row].movieID))
        }
        else {
            viewModel.makeDetailView(movieID: String(self.movies[indexPath.row].movieID))
        }
    }
}

extension HomeView: UISearchControllerDelegate{
    func searchBarCancelButtonClicked (_ searchBar: UISearchBar){
        searchController.isActive = false
        reloadTableView()
    }
}
