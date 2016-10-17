//
//  NHPhotosSliderViewController.swift
//  NHPhotosViewer
//
//  Created by Hung on 18/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit

/// for viewing photo details and sliding prev/next photo
open class NHPhotosSliderViewController: UIViewController {

    public weak var delegate: NHPhotosViewControllerDelegate?
    public var scrollView: NHImageScrollView? = nil
    public var curPhotoIndex: Int = 0 {
        didSet {
            
            if let delegate = delegate {
                if curPhotoIndex > -1 {
                    let photo = delegate.photo(photoController: self, index: curPhotoIndex)
                    scrollView?.photo = photo
                }
                else {
                    print ("NHPhotosSliderViewController - Error: negative photo index: \(curPhotoIndex) , unable to retrieve photo")
                }
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)   {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup(){
        scrollView = NHImageScrollView(frame: self.view.bounds)
        self.view.addSubview(scrollView!)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
