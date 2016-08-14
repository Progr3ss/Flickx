//
//  HomeScreenViewController.swift
//  Flickx
//
//  Created by martin chibwe on 8/9/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	var appDelegate: AppDelegate!
	var movies: [Movie] = [Movie]()
	var genreId: Int? = nil
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		 layoutHeight()
		
		appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
	}
	


}


extension HomeScreenViewController: UICollectionViewDataSource {
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 12
	}
	
	 func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnnotatedPhotoCell", forIndexPath: indexPath) as! AnnotatedMovieCell
		
		//cell.photo = photos[indexPath.item]
		
		return cell
	}
	
	
}


extension HomeScreenViewController {
	
	func layoutHeight()  {
		
		if let patternImage = UIImage(named: "Pattern") {
			view.backgroundColor = UIColor(patternImage: patternImage)
		}
		
		collectionView!.backgroundColor = UIColor.clearColor()
		collectionView!.contentInset = UIEdgeInsets(top: 2, left: 5, bottom: 10, right: 5)
		view.backgroundColor = UIColor.blackColor()
		let layout = collectionView.collectionViewLayout as! FlickxLayout
		layout.cellPadding = 5
		layout.delegate = self
		layout.numberOfColumns = 2
		
	}
	func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 100
	}
	
}
extension HomeScreenViewController: FlickxLayoutDelegate{
	
	
	

	func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
		return 30
	}
	
	
	func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
		let random = arc4random_uniform(4) + 1
		return CGFloat(random * 100)
		
		//TO-DO - get photos from the Movie Data Base
		//		let photo = photos[indexPath.item]
		//		let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
		//		let rect = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect )
		//		return rect.height
		
	}

}

