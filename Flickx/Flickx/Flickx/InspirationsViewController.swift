//
//  InspirationsViewController.swift
//  Flickx
//
//  Created by martin chibwe on 8/10/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class InspirationsViewController: UIViewController {
	
//	let inspirations = Inspiration.
//	let inspirations = Inspiration.allInspirations()
	let colors = UIColor.palette()
	
	@IBOutlet weak var collectionView: UICollectionView!
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView!.backgroundColor = UIColor.clearColor()
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast
		let layout = collectionView.collectionViewLayout
//		layout.number
        // Do any additional setup after loading the view.
    }



}

extension InspirationsViewController: UICollectionViewDataSource{
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! InspirationCell
//	  cell.contentView.backgroundColor = colors[indexPath.item]
//		 cell.inspiration = inspirations[indexPath.item]
		cell.prepareForReuse()
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 12
	}

	
}