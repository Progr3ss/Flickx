//
//  GCDBlackBox.swift
//  Flickx
//
//  Created by martin chibwe on 8/11/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation
func performUIUpdatesOnMain(updates: () -> Void) {
	dispatch_async(dispatch_get_main_queue()) {
		updates()
	}
}