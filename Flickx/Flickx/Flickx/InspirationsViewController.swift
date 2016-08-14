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
	var genreID: Int? = nil

	@IBOutlet weak var collectionView: UICollectionView!
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView!.backgroundColor = UIColor.clearColor()
		collectionView.decelerationRate = UIScrollViewDecelerationRateFast
		
		appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		genreID = genreIDFromItemTag(tabBarItem.tag)
		
		

    }
	
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		let methodParameters = [
			 Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey
		
		]
		
		let request = NSMutableURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/genre/\(genreID!)/movies"))
		
		request.addValue("applicaiton/json", forHTTPHeaderField: "Accept")
		
		
		let task = appDelegate.sharedSession.dataTaskWithRequest(request){(data, response,error) in
			
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
				print("Could not parse the data as JSOn: \(data)")
				return
				
			}
			
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int{
				print("TheMovieDB returned an error. See the '\(Constants.TMDBResponseKeys.StatusCode)' and '\(Constants.TMDBResponseKeys.StatusMessage)' in \(parsedResult)")
			}
			
			guard let result = parsedResult[Constants.TMDBResponseKeys.Results] as? [[String:AnyObject]] else{
				
				print("Cannot find key \(Constants.TMDBResponseKeys.Results) in \(parsedResult)")
				return
				
			}
			
			
			self.movies = Movie.moviesFromResults(result)
			performUIUpdatesOnMain({ 
				
				self.collectionView.reloadData()
			})
			
			
			
			
			
		
		
		
		
		}//end of task
		task.resume()

	}



}

extension InspirationsViewController: UICollectionViewDataSource{
	
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let movie = movies[indexPath.row]
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InspirationCell", forIndexPath: indexPath) as! InspirationCell
		
		cell.titleLabel!.text = movie.title
		cell.imageView!.image = UIImage(named: "Inspiration-1")
//		cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
		
		
		if let postPath = movie.posterPath{
			
			let baseURL = NSURL(string: appDelegate.config.baseImageURLString)!
			let url = baseURL.URLByAppendingPathComponent("w154").URLByAppendingPathComponent(postPath)
			print("The URL IS \(url)")
			
			let request = NSURLRequest(URL: url)
			
			
			let task = appDelegate.sharedSession.dataTaskWithRequest(request){(data, response, error) in
				
				guard(error == nil) else{
					print("There was an error with your request:\(error)")
					return
				}
				
				guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
					
					print("Your request returned a status code other than 2xx!")
					return
					
				}
				
				guard let data = data else{
					print("No data was returned by the request!")
					return
				}
				
				
				// data is already raw image data
				
				if let image = UIImage(data: data){
					performUIUpdatesOnMain({ 
						cell.imageView!.image = image
					})
				}else{
					print("Could not creae image from \(data)")
				}
			
			
			
			
			
			
			
			}//end of task
			
			task.resume()
			
			
			
			
			
			
		}
		

		return cell
	}
	
	
	
	
	
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}

	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movies.count
	}

	
}

extension InspirationsViewController {
	
	private func genreIDFromItemTag(itemTag: Int) -> Int {
		
		let genres: [String] = [
			"Sci-Fi",
			"Comedy",
			"Action"
		]
		
		let genreMap: [String:Int] = [
			"Action": 28,
			"Sci-Fi": 878,
			"Comedy": 35
		]
		
		return genreMap[genres[itemTag]]!
	}
}
