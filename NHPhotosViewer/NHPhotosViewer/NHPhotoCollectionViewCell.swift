//
//  NHPhotoCollectionViewCell.swift
//  NHPhotosViewer
//
//  Created by Hung on 16/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit
import Kingfisher

public class NHPhotoCollectionViewCell: UICollectionViewCell {
    
    public var imageView: UIImageView?
    public var photo: NHPhoto? {
        didSet {
            if let photo = photo {
                if let url = photo.image_url {
                    imageView?.kf.setImage(with: url, placeholder: photo.placeholder_image )
                }
                else if let img = photo.image  {
                    imageView?.image = img
                }
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        imageView = UIImageView(frame: self.bounds)
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        imageView?.autoresizingMask = [.flexibleWidth , .flexibleHeight ]
        self.addSubview(imageView!)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = self.bounds
    }
}
