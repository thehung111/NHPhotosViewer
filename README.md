# NHPhotosViewer
Simple photos viewer written in Swift.

![Swift](http://img.shields.io/badge/swift-3.0-brightgreen.svg)

NHPhotosViewer is designed to be presented within a navigation controller. Simply set the delegate (which must conform to `NHPhotosViewControllerDelegate`) and implement the 2 required delegate methods to provide the photo viewer with the data in the form of NHPhoto objects. You can create an NHPhoto object by providing a UIImage object, or a URL containing the path to a file or an image online. 

Downloading/caching of images are done via [Kingfisher](https://github.com/onevcat/Kingfisher) library.

## Status

Project under development. Missing many features. Just a very simple image gallery for now.

## Installation via CocoaPods

`pod "NHPhotosViewer" `

## Code Example

```swift

import NHPhotosViewer
...

override func viewDidLoad() {
	let urls : [String] =
	[   
	    "http://somedomain.com/image.png",
	    "http://somedomain.com/anotherimage.png",
	    ...
	]
	
	...
	
	for url in urls {
	    let photo = NHPhoto(url: URL(string: url)! )
	    // set placeholder image if necessary
	    //photo.placeholder_image = placeholderImg
	    photos.append(photo)
	}
	        
	self.viewer = NHPhotosViewController()
	self.viewer?.delegate = self
	self.viewer?.numOfColumns = 4

}

// open viewer with navigation controller
@IBAction func openViewer(_ sender: AnyObject) {
        
    self.viewer?.navigationItem.title = "Photos"
    self.navigationController?.pushViewController(self.viewer!, animated: false)
    
}

//NHPhotosViewControllerDelegate
func numOfPhotos(photoController: UIViewController ) -> Int{
    return photos.count
}
    
func photo(photoController: UIViewController, index: Int) -> NHPhoto {
    return photos[index]
}


```



