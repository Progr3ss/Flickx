//
//  CustomImageFlowLayout.swift
//  Flickx
//
//  Created by martin chibwe on 8/14/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {
	
	override init() {
		super.init()
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
	
	override var itemSize: CGSize {
		set {
			
		}
		get {
			let numberOfColumns: CGFloat = 2
			
			let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - (numberOfColumns - 1)) / numberOfColumns
			return CGSizeMake(itemWidth, itemWidth)
		}
	}
	
	func setupLayout() {
		minimumInteritemSpacing = 1
		minimumLineSpacing = 1
	
		scrollDirection = .Vertical
	}
	
}

