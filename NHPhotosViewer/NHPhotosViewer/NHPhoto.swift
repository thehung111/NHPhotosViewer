//
//  NHPhoto.swift
//  NHPhotosViewer
//
//  Created by Hung on 16/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit

open class NHPhoto: NSObject {
    
    // MARK: properties
    
    /// photo caption
    public var caption: String?
    
    /// underlying image. This take precendence over image url. If set, image url will be ignored
    public var image: UIImage?
    
    /// image url to load
    public var image_url : URL?
    
    /// placeholder image if image url is broken or loading
    public var placeholder_image : UIImage?
    
    // MARK: constructors
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
