//
//  Genre.swift
//  Flickx
//
//  Created by martin chibwe on 8/13/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation


struct Genre {
	// MARK: Properties
	
	let id: Int
	let name: String

	
	// MARK: Initializers
	
	init(dictionary: [String:AnyObject]) {

		
		id = dictionary[Constants.TMDBResponseKeys.ID] as! Int
		
		name = dictionary[Constants.TMDBResponseKeys.Name] as! String
		

	}
	
	static func genreFromResults(results: [[String:AnyObject]]) -> [Genre] {
		
		var genre = [Genre]()
		
		// iterate through array of dictionaries, each Movie is a dictionary
		for result in results {
			genre.append(Genre(dictionary: result))

		}
		
		return genre
	}
	
}