//
//  HomeScreenViewController.swift
//  Flickx
//
//  Created by martin chibwe on 8/9/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit
import AVFoundation
class HomeScreenViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	var collectionViewLayout: CustomImageFlowLayout!
	var appDelegate: AppDelegate!
	var movies: [Movie] = [Movie]()
	var photos = [UIImage]()
	var genreId: Int? = nil
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()


		collectionViewLayout = CustomImageFlowLayout()
		collectionView.collectionViewLayout = collectionViewLayout
		collectionView.backgroundColor = .blackColor()
		
		appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//		getPlaying_NowMovies()
		
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		getPlayingNowMovies()
	}
	
	func getPopularMovies(){
	}
	
	
	func getPlayingNowMovies()  {
		
		/* 1. Set the parameters */
		let methodParameters = [
			Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey
		]
		
		/* 2/3. Build the URL, Configure the request */
		let request = NSMutableURLRequest(URL: appDelegate.tmdbURLFromParameters(methodParameters, withPathExtension: "/movie/now_playing"))
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		
		/* 4. Make the request */
		let task = appDelegate.sharedSession.dataTaskWithRequest(request) { (data, response, error) in
			
			/* GUARD: Was there an error? */
			guard (error == nil) else {
				print("There was an error with your request: \(error)")
				return
			}
			
			/* GUARD: Did we get a successful 2XX response? */
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
				print("Your request returned a status code other than 2xx!")
				return
			}
			
			/* GUARD: Was there any data returned? */
			guard let data = data else {
				print("No data was returned by the request!")
				return
			}
			
			/* 5. Parse the data */
			let parsedResult: AnyObject!
			do {
				parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
			} catch {
				print("Could not parse the data as JSON: '\(data)'")
				return
			}
			
			/* GUARD: Did TheMovieDB return an error? */
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
				print("TheMovieDB returned an error. See the '\(Constants.TMDBResponseKeys.StatusCode)' and '\(Constants.TMDBResponseKeys.StatusMessage)' in \(parsedResult)")
				return
			}
			
			/* GUARD: Is the "results" key in parsedResult? */
			guard let results = parsedResult[Constants.TMDBResponseKeys.Results] as? [[String:AnyObject]] else {
				print("Cannot find key '\(Constants.TMDBResponseKeys.Results)' in \(parsedResult)")
				return
			}
			
			/* 6. Use the data! */
			self.movies = Movie.moviesFromResults(results)
//			print(results)
			
//			print(self.movies)
			
			performUIUpdatesOnMain {
				
				self.collectionView.reloadData()
				
			}
		}
		
		/* 7. Start the request */
		task.resume()
	}
	


}


extension HomeScreenViewController: UICollectionViewDataSource {
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movies.count
	}
	
	 func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnnotatedPhotoCell", forIndexPath: indexPath) as! AnnotatedMovieCell
		
		let movie = movies[indexPath.row]
//		cell.contentView.
//		cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
		
		//cell.photo = photos[indexPath.item]
		
		
		
//		return cell
		/* TASK: Get the poster image, then populate the image view */
		if let posterPath = movie.posterPath {
			
			/* 1. Set the parameters */
			// There are none...
			
			/* 2. Build the URL */
			let baseURL = NSURL(string: appDelegate.config.baseImageURLString)!
			print(" BaseURL \(baseURL)")
			let url = baseURL.URLByAppendingPathComponent("original").URLByAppendingPathComponent(posterPath)
			print("url \(url)")
			
			/* 3. Configure the request */
			let request = NSURLRequest(URL: url)
			
			/* 4. Make the request */
			let task = appDelegate.sharedSession.dataTaskWithRequest(request) { (data, response, error) in
				
				/* GUARD: Was there an error? */
				guard (error == nil) else {
					print("There was an error with your request: \(error)")
					return
				}
				
				/* GUARD: Did we get a successful 2XX response? */
				guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
					print("Your request returned a status code other than 2xx!")
					return
				}
				
				/* GUARD: Was there any data returned? */
				guard let data = data else {
					print("No data was returned by the request!")
					return
				}
				
				/* 5. Parse the data */
				// No need, the data is already raw image data.
				
				self.photos.append(UIImage(data:data)!)
				
				/* 6. Use the data! */
				
//				 loadImageWithURL(data)
				if let image = UIImage(data: data) {
					performUIUpdatesOnMain {
						
						cell.imageView!.image = image
//						cell.imageView!.image = self.photos[indexPath.]
						
					}
				} else {
					print("Could not create image from \(data)")
				}
			}
			
			/* 7. Start the request */
			task.resume()
		}
		
		return cell
	}
	
	
}




