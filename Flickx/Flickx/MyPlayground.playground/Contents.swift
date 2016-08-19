////: Playground - noun: a place where people can play
//
//import Cocoa
//
//
//
////Genre
//let url = NSURL(string: "http://api.themoviedb.org/3/genre/movie/list")!
//let request = NSMutableURLRequest(URL: url)
//request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//let session = NSURLSession.sharedSession()
//let task = session.dataTaskWithRequest(request) { data, response, error in
//	let parsedResult: AnyObject!
//	
//	do{
//		parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
//		
//	}catch{
//		print("Could not parse the data as JSOn: \(data)")
//		return
//	}
//	
//	print(parsedResult)
//	
//	if let response = response, data = data {
//	
//	} else {
//		print(error)
//	}
//	
//}
//
//task.resume()




//gettitng moveis 
if let postPath = movie.posterPath{
	
	let baseURL = NSURL(string: appDelegate.config.baseImageURLString)!
	let url = baseURL.URLByAppendingPathComponent("w342").URLByAppendingPathComponent(postPath)
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
