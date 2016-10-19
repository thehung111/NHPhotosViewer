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
        self.view = scrollView!
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(NHPhotosSliderViewController.toggle(sender:)) )
        scrollView!.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(NHPhotosSliderViewController.doubleTap(recognizer:)) )
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView!.addGestureRecognizer(doubleTapGesture)
        
        // make sure that double tap take priority for zooming
        singleTapGesture.require(toFail: doubleTapGesture)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    // MARK: standard view methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: double tap to zoom
    func doubleTap(recognizer: UITapGestureRecognizer) {
        if let scrollView = self.scrollView {
            let pointInView = recognizer.location(in: scrollView.imageView!)
        
            var newZoomScale = scrollView.maximumZoomScale;

            if (scrollView.zoomScale >= scrollView.maximumZoomScale
                || abs(scrollView.zoomScale - scrollView.maximumZoomScale) <= 0.01) {
               
                newZoomScale = scrollView.minimumZoomScale;
            }
            
            let scrollViewSize = scrollView.bounds.size;

            let width   : CGFloat = scrollViewSize.width / newZoomScale;
            let height  : CGFloat = scrollViewSize.height / newZoomScale;
            let originX : CGFloat = pointInView.x - (width / 2.0);
            let originY : CGFloat = pointInView.y - (height / 2.0);

            let rectToZoomTo : CGRect = CGRect(x: originX, y: originY, width: width, height: height);
            scrollView.zoom(to: rectToZoomTo, animated: true)

        }
    }
    
    //MARK: toggle navigation bar, status bar
    func toggle(sender: AnyObject) {
        
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
    }
    
    
    override open var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden == true
    }
    
    
    open override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
