//
//  InspirationsViewController.swift
//  Flickx
//
//  Created by martin chibwe on 8/10/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class InspirationsViewController: UIViewController {
	
	var appDelegate: AppDelegate!
	var movies: [Movie] = [Movie]()
	var genres: [Genre] = [Genre]()
	var genreID: Int? = nil

	@IBOutlet weak var collectionView: UICollectionView!
//	var collectionViewLayout:UltravisualLayoutNumberOfColumns!
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView!.backgroundColor = UIColor.clearColor()
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast
		
	
//		collectionView.collectionViewLayout = collectionViewLayout
		appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		
	
		
		
//		genreID = genreIDFromItemTag(2)
		
		

    }
	
	
	
	
	func getMovieGenre()  {
		
		
		let methodParameters = [
			Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey
			
		]
		
		//		let request = NSMutableURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/genre/\(genreID!)/movies"))
		
		let request2 = NSMutableURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/genre/movie/list"))
		
		print("The request is \(request2)")
		
		request2.addValue("applicaiton/json", forHTTPHeaderField: "Accept")
		
		
		let task = appDelegate.sharedSession.dataTaskWithRequest(request2){(data, response,error) in
			
			guard (error == nil ) else {
				print("There was an error with your reques: \(error)")
				return
			}
			
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else{
				
				print("Your request returned a status code other than 2xx!")
				return
				
			}
			
			guard let data = data else{
				print("No data was reeturned by the reqeust!")
				return
			}
			
			
			let parsedResult: AnyObject!
			
			do{
				parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
				
			}catch{
				print("Could not parse the data as Jsonn: \(data)")
				return
				
			}
			
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int{
				print("TheMovieDB returned an error. See the '\(Constants.TMDBResponseKeys.StatusCode)' and '\(Constants.TMDBResponseKeys.StatusMessage)' in \(parsedResult)")
			}
			
			guard let result = parsedResult[Constants.TMDBResponseKeys.Genres] as? [[String:AnyObject]] else{
				
				print("Cannot find key \(Constants.TMDBResponseKeys.Genres) in \(parsedResult)")
				return
				
			}
			
			
			print("result \(result)")
			self.genres = Genre.genreFromResults(result)
			performUIUpdatesOnMain {
				self.collectionView.reloadData()
			}
			
			
			
			
			
			
			
		}//end of task
		task.resume()

	
	}
	
	func getMovieGenreID()  {
		
		let methodParameters = [
			Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey
			
		]
		
		//		let request = NSMutableURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/genre/\(genreID!)/movies"))
		
		let request2 = NSMutableURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/genre/\(genreID!)movies"))
		
		print("The request is \(request2)")
		
		request2.addValue("applicaiton/json", forHTTPHeaderField: "Accept")
		
		
		let task = appDelegate.sharedSession.dataTaskWithRequest(request2){(data, response,error) in
			
			guard (error == nil ) else {
				print("There was an error with your reques: \(error)")
				return
			}
			
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else{
				
				print("Your request returned a status code other than 2xx!")
				return
				
			}
			
			guard let data = data else{
				print("No data was reeturned by the reqeust!")
				return
			}
			
			
			let parsedResult: AnyObject!
			
			do{
				parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
				
			}catch{
				print("Could not parse the data as Jsonn: \(data)")
				return
				
			}
			
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int{
				print("TheMovieDB returned an error. See the '\(Constants.TMDBResponseKeys.StatusCode)' and '\(Constants.TMDBResponseKeys.StatusMessage)' in \(parsedResult)")
			}
			
			guard let result = parsedResult[Constants.TMDBResponseKeys.Genres] as? [[String:AnyObject]] else{
				
				print("Cannot find key \(Constants.TMDBResponseKeys.Genres) in \(parsedResult)")
				return
				
			}
			
			
			print("result \(result)")
			self.genres = Genre.genreFromResults(result)
			performUIUpdatesOnMain {
				self.collectionView.reloadData()
			}
			
			
			
			
			
			
			
		}//end of task
		task.resume()

	}
	
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		getMovieGenre()
//		getMovieGenreID()

	}
//
	
	
	



}

extension InspirationsViewController: UICollectionViewDataSource{
	
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let genre = genres[indexPath.row]
		

		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! InspirationCell
		
		
		
		
		cell.titleLabel.text = genre.name
		

		
		cell.imageView!.image = UIImage(named: "Inspiration-1")
		
		

		

		

		return cell
	}
	
	
	
	
	
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}

	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

//		print(" Count is genres \(genres.count)")
		return genres.count
		
	}

	
}


extension InspirationsViewController: UICollectionViewDelegate {
//	self.getIndexPath()
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		
		if indexPath.row == 0{
		}else if indexPath.row == 1{
			
			
		}else if indexPath.row == 2{
			
		}else if indexPath.row == 3{
			
		}else if indexPath.row == 4{
			
		}else if indexPath.row == 5{
			
		}else if indexPath.row == 6{
			
		}else if indexPath.row == 7{
			
		}else if indexPath.row == 8{
			
		}else if indexPath.row == 9{
			
		}else if indexPath.row == 10{
			
		}else if indexPath.row == 11{
			
		}else if indexPath.row == 12{
			
		}else if indexPath.row == 13{
			
		}else if indexPath.row == 14{
			
		}else if indexPath.row == 15{
			
		}else if indexPath.row == 16{
			
		}else if indexPath.row == 17{
			
		}else if indexPath.row == 18{
			
		}else if indexPath.row == 19{
			
		}

		
		
		
		
	
		
		
	}
	

}
