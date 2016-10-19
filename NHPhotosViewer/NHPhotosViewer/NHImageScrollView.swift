//
//  NHImageScrollView.swift
//  NHPhotosViewer
//
//  Created by Hung on 17/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit
import Kingfisher

/// Class for zooming and scaling an image view within a scrollview
@IBDesignable
public class NHImageScrollView: UIScrollView, UIScrollViewDelegate {

    /// Internal image view
    @IBInspectable public var imageView: UIImageView?
    
    public var photo: NHPhoto? {
        didSet {
            if let photo = photo {
                if let img = photo.image  {
                    updateImage(image:img)
                }
                else if let url = photo.image_url {
                    self.panGestureRecognizer.isEnabled = false
                    imageView?.kf.setImage(with: url, placeholder: photo.placeholder_image , completionHandler: {
                        (image, error, cacheType, imageUrl) in
                        // image: Image? `nil` means failed
                        // error: NSError? non-`nil` means failed
                        // cacheType: CacheType
                        //                  .none - Just downloaded
                        //                  .memory - Got from memory cache
                        //                  .disk - Got from memory Disk
                        // imageUrl: URL of the image
                        
                        if let img = image {
                            self.updateImage(image:img)
                        }
                        
                        //print("error: \(error?.localizedDescription)")
                    })
                }
                
            }
        }
    }

    
    //MARK: UIView methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup(image: UIImage() )
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup(image: UIImage())
    }
    
    public init(image: UIImage , frame: CGRect){
        super.init(frame: frame)
        setup(image: image)
    }
    
    public override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        centerScrollViewContents()
    }
    
    override public var frame: CGRect {
       
        didSet {
           updateZoomScale()
           centerScrollViewContents()
        }
    }
    
    // MARK: setup
    private func setup(image: UIImage) {
        imageView = UIImageView(image: image)
        addSubview(imageView!)
        
        self.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bouncesZoom = true
        self.decelerationRate = UIScrollViewDecelerationRateFast
        
        delegate = self
        
        updateImage(image:image)
    }
    
    public func updateImage(image: UIImage){
        // Remove any transform currently applied by the scroll view zooming.
        imageView?.transform = .identity
        
        imageView?.image = image
        imageView?.frame = CGRect(x:0, y: 0, width: image.size.width, height: image.size.height )
        contentSize = image.size
        
        self.panGestureRecognizer.isEnabled =  true
        
        updateZoomScale()
        centerScrollViewContents()
    }
    
    private func updateZoomScale() {
        
        if let image = self.imageView?.image {
            if image.size.width == 0 || image.size.height == 0 {
                return
            }
            
            let scrollViewFrame = self.bounds
            
            let scaleWidth : CGFloat = scrollViewFrame.size.width / image.size.width
            let scaleHeight : CGFloat = scrollViewFrame.size.height / image.size.height
            let minScale = min(scaleWidth, scaleHeight)

            self.minimumZoomScale = minScale;
            self.maximumZoomScale = max(minScale, self.maximumZoomScale)

            self.zoomScale = self.minimumZoomScale
        }
    }
    
    public func centerScrollViewContents(){
        
        var horizontalInset : CGFloat = 0
        var verticalInset : CGFloat = 0
        
        if (self.contentSize.width < self.bounds.size.width) {
            horizontalInset = (self.bounds.size.width - self.contentSize.width) * 0.5
        }
        
        if (self.contentSize.height < self.bounds.size.height) {
            verticalInset = (self.bounds.size.height - self.contentSize.height) * 0.5
        }
     
        self.contentInset = UIEdgeInsetsMake(verticalInset, horizontalInset, verticalInset, horizontalInset)

    }
    
    //MARK: UIScrollViewDelegate
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
   
}
