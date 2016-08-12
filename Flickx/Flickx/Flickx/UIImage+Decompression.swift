//
//  UIImage+Decompression.swift
//  flickx
//
//  Created by martin chibwe on 8/8/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

extension UIImage {
	
	var decompressedImage: UIImage {
		UIGraphicsBeginImageContextWithOptions(size, true, 0)
		drawAtPoint(CGPointZero)
		let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return decompressedImage
	}
	
}

