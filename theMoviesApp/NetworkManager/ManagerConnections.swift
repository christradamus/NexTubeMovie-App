//
//  ManagerConnections.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import Foundation
import RxSwift

class ManagerConnectios {
    
    func getPopularMovies() -> Observable<[Movie]> {
        
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main+Constants.Endpoints.urlListPopularMovies+Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request){ (data , response, error) in
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else
                {return}
                
                if response.statusCode == 200 {
                    do{
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        print("\(movies.listOfMovies[0])")
                        observer.onNext(movies.listOfMovies)
                    } catch let error{
                        observer.onError(error)
                        print("Ha ocurrido un error : \(error.localizedDescription)")
                    }
                    
                }
                else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDetailMovies(movieID: String) -> Observable<MovieDetail> {
        
    return Observable.create { observer in
    
    let session = URLSession.shared
    var request = URLRequest(url: URL(string: Constants.URL.main+Constants.Endpoints.urlDetailMovie+movieID+Constants.apiKey)!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    session.dataTask(with: request){ (data , response, error) in
        
        guard let data = data, error == nil, let response = response as? HTTPURLResponse else
        {return}
        
        if response.statusCode == 200 {
            do{
                let decoder = JSONDecoder()
                let detailMovie = try decoder.decode(MovieDetail.self, from: data)
                observer.onNext(detailMovie)
            } catch let error{
                observer.onError(error)
                print("Ha ocurrido un error : \(error.localizedDescription)")
            }
            
        }
        else if response.statusCode == 401 {
            print("Error 401")
        }
        observer.onCompleted()
    }.resume()
    
    return Disposables.create{
        session.finishTasksAndInvalidate()
    }
}
    }
}
