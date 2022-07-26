//
//  Extensions.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import UIKit

extension UIImageView{
    
    func imageFromServerUrl(urlString:String, placeholderImage: UIImage){
        
        if self.image == nil {
            self.image = placeholderImage
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}
