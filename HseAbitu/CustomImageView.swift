//
//  CustomImageView.swift
//  HseAbitu
//
//  Created by Ирина Улитина on 01/02/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import Foundation
import UIKit



class CustomImageView :UIImageView {
    
    static var imageCache = [String : UIImage]()
    
    var lastURLUsedToLoadImage: String?
    
    override var bounds: CGRect {
        didSet {
            print(bounds)
            self.layer.cornerRadius = self.bounds.width / 2
        }
    }
    
    func loadImage(url : String) {
        self.image = nil
        if let cachedImage = CustomImageView.imageCache[url] {
            self.image = cachedImage
            return
        }
        
        lastURLUsedToLoadImage = url
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                print("Failed to fetch profile image", err)
                return
            }
            
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            guard let data = data else {
                return
            }
            let image = UIImage(data: data)
            CustomImageView.imageCache[url.absoluteString] = image
            DispatchQueue.main.async {
                self.image = image
            }
            }.resume()
    }
}
