//
//  AnnotatedMovieCell.swift
//  flickx
//
//  Created by martin chibwe on 8/8/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation
import UIKit


class AnnotatedMovieCell: UICollectionViewCell {
	
	@IBOutlet weak var annotatedMovieViewCell: UIView!

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
	
	
	
	override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
		super.applyLayoutAttributes(layoutAttributes)
		let attributes = layoutAttributes as! FlickxLayoutAttributes
		imageViewHeightLayoutConstraint.constant = attributes.photoHeight
	}

}

