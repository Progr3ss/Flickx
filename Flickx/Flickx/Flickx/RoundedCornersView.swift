//
//  RoundedCornersView.swift
//  flickx
//
//  Created by martin chibwe on 8/9/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable
class RoundedCornersView: UIView {
	
	@IBInspectable var cornerRadius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = cornerRadius
			layer.masksToBounds = cornerRadius > 0
		}
	}
	
}
