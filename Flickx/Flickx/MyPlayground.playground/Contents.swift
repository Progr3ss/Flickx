//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing")!
let request = NSMutableURLRequest(URL: url)
request.addValue("application/json", forHTTPHeaderField: "Accept")

let session = NSURLSession.sharedSession()
let task = session.dataTaskWithRequest(request) { data, response, error in
	if let response = response, data = data {
		print(response)
		print(String(data: data, encoding: NSUTF8StringEncoding))
	} else {
		print(error)
	}
}

task.resume()