//
//  Constants.swift
//  Flickx
//
//  Created by martin chibwe on 8/11/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

// MARK: - Constants

struct Constants {
	
	// MARK: TMDB
	struct TMDB {
		static let ApiScheme = "https"
		static let ApiHost = "api.themoviedb.org"
		static let ApiPath = "/3"
	}
	
	// MARK: TMDB Parameter Keys
	struct TMDBParameterKeys {
		static let ApiKey = "api_key"
		static let RequestToken = "request_token"
		static let SessionID = "session_id"
		static let Username = "username"
		static let Password = "password"
	}
	
	// MARK: TMDB Parameter Values
	struct TMDBParameterValues {
		static let ApiKey = "18b84113b7dd9e5d24e15c3a3ffc36b9"
	}
	
	// MARK: TMDB Response Keys
	struct TMDBResponseKeys {
		static let Title = "title"
		static let Name = "name"
		static let ID = "id"
		static let PosterPath = "poster_path"
		static let StatusCode = "status_code"
		static let StatusMessage = "status_message"
		static let SessionID = "session_id"
		static let RequestToken = "request_token"
		static let Success = "success"
		static let UserID = "id"
		static let Results = "results"
		static let Genres = "genres"
	}
	
	// MARK: UI
	struct UI {
		static let LoginColorTop = UIColor(red: 0.345, green: 0.839, blue: 0.988, alpha: 1.0).CGColor
		static let LoginColorBottom = UIColor(red: 0.023, green: 0.569, blue: 0.910, alpha: 1.0).CGColor
		static let GreyColor = UIColor(red: 0.702, green: 0.863, blue: 0.929, alpha:1.0)
		static let BlueColor = UIColor(red: 0.0, green:0.502, blue:0.839, alpha: 1.0)
	}
	
	// FIX: As of Swift 2.2, using strings for selectors has been deprecated. Instead, #selector(methodName) should be used.
	/*
	// MARK: Selectors
	struct Selectors {
	static let KeyboardWillShow: Selector = "keyboardWillShow:"
	static let KeyboardWillHide: Selector = "keyboardWillHide:"
	static let KeyboardDidShow: Selector = "keyboardDidShow:"
	static let KeyboardDidHide: Selector = "keyboardDidHide:"
	}
	*/
}
