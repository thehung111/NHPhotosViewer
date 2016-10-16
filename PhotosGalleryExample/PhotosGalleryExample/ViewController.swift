//
//  ViewController.swift
//  PhotosGalleryExample
//
//  Created by Hung on 16/10/16.
//  Copyright © 2016 Ngo Hung. All rights reserved.
//

import UIKit
import NHPhotosViewer
import Kingfisher

class ViewController: UIViewController, NHPhotosViewControllerDelegate {

    private var photos: [NHPhoto] = []
    private var viewer: NHPhotosViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // random cat pictures
        let urls : [String] =
                    [   "http://24.media.tumblr.com/tumblr_m3dr46KfE41r73wdao1_500.jpg",
                        "http://24.media.tumblr.com/tumblr_lydjzwPcax1qzsbdto1_250.gif",
                        "http://25.media.tumblr.com/tumblr_m3pm3tucRT1qjahcpo1_1280.jpg",
                        "http://24.media.tumblr.com/tumblr_lxst6fyCxS1qb7j67o1_500.jpg",
                        "http://25.media.tumblr.com/tumblr_m7spyibH8M1qaez2ro1_500.jpg",
                        "http://24.media.tumblr.com/ZabOTt2mpdqnm6k4JXjnAe7D_500.jpg",
                        "http://25.media.tumblr.com/tumblr_m1aryygjTZ1qzv52ko1_500.jpg",
                        "http://25.media.tumblr.com/tumblr_m2b11z7hT41qgjltdo1_500.jpg",
                        "http://24.media.tumblr.com/tumblr_m0apfqollY1qbc132o1_500.png",
                        "http://24.media.tumblr.com/tumblr_lom5ads6bQ1qh66wqo1_500.jpg",
                        "http://27.media.tumblr.com/tumblr_m33tqurL3r1qzex9io1_1280.jpg",
                        "http://25.media.tumblr.com/tumblr_m2lzsjdSf41qze6dko1_1280.jpg",
                        "http://25.media.tumblr.com/tumblr_lyh6hdod1r1r23g2co1_500.jpg",
                        "http://25.media.tumblr.com/tumblr_lhlj908K5O1qgnva2o1_400.jpg"
                    ]
        
        for url in urls {
            let photo = NHPhoto(url: URL(string: url)! )
            photos.append(photo)
        }
        
        self.viewer = NHPhotosViewController()
        self.viewer?.delegate = self
        self.viewer?.numOfColumns = 4
        
    }
    
    // MARK: buttons click
    @IBAction func openViewer(_ sender: AnyObject) {
        
        self.viewer?.navigationItem.title = "Photos"
        self.navigationController?.pushViewController(self.viewer!, animated: false)
        
    }
    

    //MARK: NHPhotosViewControllerDelegate
    func numOfPhotos(photoController: NHPhotosViewController ) -> Int{
        return photos.count
    }
    
    func photo(photoController: NHPhotosViewController, index: Int) -> NHPhoto {
        return photos[index]
    }


}

