//
//  UIImageView+LoadImageInCache.swift
//  NYTimes
//
//  Created by Eduard Galchenko on 04.11.2019.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import Alamofire
import AlamofireImage

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func loadImageInCache(with urlString: String) {

        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {

            self.image = cachedImage
            return
        }

        Alamofire.request(urlString).responseImage { response in

            if let downloadedImage = response.result.value {

                imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                self.image = downloadedImage
            }
        }
    }
}
