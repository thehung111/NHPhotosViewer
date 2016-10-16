//
//  NHPhoto.swift
//  NHPhotosViewer
//
//  Created by Hung on 16/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit

open class NHPhoto: NSObject {
    public var caption: String?
    public var image: UIImage?
    public var image_url : URL?
    public var placeholder_image : UIImage?
    
    public init(image: UIImage){
        self.image = image
    }
    
    public init(url: URL){
        self.image_url = url
    }
    
    public init(string: String){
        self.image_url = URL(string: string)
    }

}
