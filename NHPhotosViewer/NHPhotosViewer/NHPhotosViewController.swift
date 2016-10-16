//
//  NHPhotosViewController.swift
//  NHPhotosViewer
//
//  Created by Hung on 16/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NHPhotoCollectionViewCell"

public protocol NHPhotosViewControllerDelegate: class {
    func numOfPhotos(photoController: NHPhotosViewController ) -> Int
    func photo(photoController: NHPhotosViewController, index: Int) -> NHPhoto
}

open class NHPhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    /// delegate for getting photos and possible interaction events
    public weak var delegate: NHPhotosViewControllerDelegate?
    
    /// spacing at the top
    public var topSpacing : CGFloat = 1.0 {
        didSet{
            let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
            layout.headerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: topSpacing)
        }
    }
    
    /// spacing at the bottom
    public var bottomSpacing : CGFloat = 1.0 {
        didSet{
            let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
            layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: topSpacing)
        }
    }
    
    /// number of columns in the grid
    public var numOfColumns : Int = 3 {
        didSet{
            reloadLayout()
        }
    }
    
    /// spacing between items on same row
    public var itemSpacing  : CGFloat = 1.0 {
        didSet{
            reloadLayout()
        }
    }

    
    /// spacing between lines
    public var lineSpacing  : CGFloat = 1.0 {
        didSet{
            reloadLayout()
        }
    }
    
    
    /// MARK: init methods
    public init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// common override methods
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        reloadLayout()

        // Register cell classes
        self.collectionView!.register(NHPhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: layout methods
    
    /// reload layout e.g. if there are changes in number of columns or spacing
    open func reloadLayout(){
        
        // reset number of columns to 2 if invalid
        if(numOfColumns < 1){
            numOfColumns = 1
            print ("There must be at least 1 column")
        }
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = floor(  (view.bounds.size.width - CGFloat(numOfColumns - 1) * itemSpacing ) / CGFloat(numOfColumns))
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = lineSpacing
        
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: topSpacing)
        layout.headerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: bottomSpacing)
        layout.scrollDirection = .vertical
    }

    
    // MARK: UICollectionViewDataSource

    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let delegate = delegate {
            return delegate.numOfPhotos(photoController: self);
        }
        
        return 0
    }

    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NHPhotoCollectionViewCell
    
        // Configure the cell
        if let delegate = delegate {
            let photo = delegate.photo(photoController: self, index: indexPath.row)
            cell.photo = photo
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
