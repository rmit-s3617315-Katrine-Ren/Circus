//
//  CODE DUMP.swift
//  Circus-Imgs
//
//  Created by Rita Tse on 27/9/17.
//  Copyright © 2017 s3419529. All rights reserved.
//


    //var fetchedFlickrImage = [FlickrImage]()

/*
 //parsedata
 func parseData() {
 
 fetchedFlickrImage = []
 
 let url = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=\(apiKey)&date=&extras=geo%2C+tags%2C+machine_tags%2C+url_sq%2C&format=json&nojsoncallback=1"
 
 var request = URLRequest(url: URL(string: url)!)
 request.httpMethod = "GET"
 
 
 let config = URLSessionConfiguration.default
 let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
 
 let task = session.dataTask(with: request) { (data, response, error) in
 
 if (error != nil) {
 print("Error")
 }
 else {
 
 do {
 
 let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
 print(fetchedData)
 
 for eachFetchedFlickrImage in fetchedData {
 
 //let eachFlickrImage = eachFetchedFlickrImage as! [String : Any]
 
 let eachFlickrImage = eachFetchedFlickrImage as? [String: Any]
 
 //let flickrImg = eachImage["id"] as! String
 let flickrImgTitle = eachFlickrImage?["title"] as! String
 let flickrImgURL = eachFlickrImage?["url_sq"] as! String
 
 self.fetchedFlickrImage.append(FlickrImage(title: flickrImgTitle, imgURLSQ: flickrImgURL))
 }
 
 print(self.fetchedFlickrImage)
 
 }
 catch {
 print("Error 2")
 }
 }
 }
 task.resume()
 }
 
 
 class FlickrImage {
 
 //var thumbnail : UIImage?
 //var largeImage : UIImage?
 // let photoID : String
 let title : String
 //let farm : Int
 //let server : String
 //let secret : String
 //let latitude : Double
 //let longitude : Double
 //let tags: Array<String>
 let imgURLSQ : String
 
 init (title:String, imgURLSQ: String) {
 // init (photoID:String, title:String, farm:Int, server:String, secret:String, latitude: Double, longitude: Double, tags:Array<String>) {
 //self.photoID = photoID
 self.title = title
 //self.farm = farm
 //self.server = server
 //self.secret = secret
 //self.latitude = latitude
 //self.longitude = longitude
 //self.tags = tags
 self.imgURLSQ = imgURLSQ
 }
 
 }
 */








//--------------------------------------------------
//
//try this later...

// let photoURL =  URL(string: "https://farm\(imgsFarm[indexPath.row]).staticflickr.com/\(imgsServer[indexPath.row])/\(imgsID[indexPath.row])_\(imgsSecret[indexPath.row])_\(size).jpg")

//--------------------------------------------------









/*
 func downloadJSONURL(){
 //download with URL
 
 let url = NSURL(string: urlString)
 
 URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
 
 if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
 print(jsonObj!.value(forKey: "photo"))
 
 if let imgArray = jsonObj!.value(forKey: "title") as? NSArray {
 for photo in imgArray{
 if let imgDict = photo as? NSDictionary {
 if let title = imgDict.value(forKey: "name") {
 self.imgsTitle.append(title as! String)
 }
 if let img75 = imgDict.value(forKey: "url_sq") {
 self.imgs75URL.append(img75 as! String)
 }
 
 }
 }
 }
 
 OperationQueue.main.addOperation({
 self.tableView.reloadData()
 })
 }
 }).resume()
 }
 */


/*
 //following tutorial
 let session = URLSession.shared
 
 //constants for URL Requests
 let BASE_URL: String = "https://api.flickr.com/services/rest/?"
 let METHOD_NAME:String = "flickr.interestingness.getList"
 // You will need to add your own API Key here
 let API_KEY:String = "?api_key=\(AppDelegate.key)"
 let EXTRAS:String! = "url_m"
 let DATA_FORMAT:String! = "json"
 let SAFE_SEARCH:String!="1"
 let NO_JSON_CALLBACK:String! = "1"
 
 
 //----------
 */

/*
 if let photoArray = (jsonData! as AnyObject).value(forKey: "photos") as? NSDictionary
 {
 //if let imgArray = jsonData!.value(forKey: "photo") as? NSArray {
 for photo in photoArray
 {
 if let imgDict = photo
 {
 if let title = imgDict.value(forKey: "title") {
 print("title: \(title)")
 self.imgsTitle.append(title as! String)
 }
 if let farm = imgDict.value(forKey: "farm") {
 print("farm: \(farm)")
 self.imgsFarm.append(farm as! Int)
 }
 if let photoID = imgDict.value(forKey: "id") {
 print("id: \(photoID)")
 self.imgsID.append(photoID as! String)
 }
 if let secret = imgDict.value(forKey: "secret") {
 print("secret: \(secret)")
 self.imgsSecret.append(secret as! String)
 }
 if let server = imgDict.value(forKey: "server") {
 print("server: \(server)")
 self.imgsServer.append(server as! String)
 }
 if let img75 = imgDict.value(forKey: "url_sq") {
 print("url_sq: \(img75)")
 self.imgs75URL.append(img75 as! String)
 }
 
 // OperationQueue.main.addOperation({
 //self.tableView.reloadData()
 
 //})
 // self.checkData()
 }
 }
 }
 */
