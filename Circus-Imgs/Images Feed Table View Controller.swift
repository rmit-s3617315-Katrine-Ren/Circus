//
//  Images Feed Table View Controller.swift
//  Circus-Imgs
//
//  Created by Rita Tse on 21/8/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import UIKit
import SwiftyJSON

    //move to Model
    let apiKey = "c21fa3df81455afb0cd447e13ea34179"


class ImagesFeedTableViewController: UITableViewController {
    
    @IBAction func favourite(_ sender: Any) {
       // Model.get.saveMovie(	name.text!, subtitle: desc.text, imageName: imageName.text!, existing: currentMovie)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(30,0,0,0)
        downloadJSON()
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


    
    //TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        //one column
        return 1
    }
    
        //returns a set of images each load
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return photosArray.count
        //when JSON is in Model
        //return Model.get.photosArray.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! MyCell
        
        let photo = photosArray[indexPath.row]
        
        //when JSON is in Model
        //let photo = Model.get.photosArray[indexPath.row]
        
        cell.labelRight.text = photo.photoTitle
        
    
        let imgLink = URL(string: photo.photoURL)
        
        if (imgLink != nil) {
            let data = NSData(contentsOf: (imgLink)!)
            cell.myImage.image = UIImage(data: data! as Data)
        }
 
        return cell
    }
    
    
    //For DetailView after Image is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {

    }
    

    
    //REST API Call - move to Model
    final let urlString = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=\(apiKey)&extras=geo%2C+tags%2C+machine_tags%2C+url_z&format=json&nojsoncallback=1"
    
    //create Photos array from Model
    var photosArray = [Photos]()
    
    
    //DOWNLOAD JSON- move to model
    func downloadJSON()
    {
        
        let url = URL(string: urlString)
        
        var downloadTask = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 5)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData: JSON? = JSON(data!)
            if (jsonData != nil)
            {
                let photos = jsonData?["photos"].dictionaryValue
                //print(photos!)
                
                for (key, element) in photos!
                {
                    if (key == "photo")
                    {
                        for item in element.arrayValue
                        {
                            let urlStr: String = {
                                if let photoURL = item["url_z"].string {
                                    return photoURL as! String
                                }
                                return "Not Found"
                            }()
                            
                            let titleStr: String = {
                                if let photoTitle = item["title"].string {
                                    return photoTitle as! String
                                }
                                return "Untitled"
                            }()
                            
                            let placeIDStr: String = {
                                if let placeID = item["place_id"].string {
                                    return placeID as! String
                                }
                                return "Not Found"
                            }()
                            
                            let latStr: String = {
                                if let photoLat = item["latitude"].string {
                                    return photoLat as! String
                                }
                                return "Not Found"
                            }()
                            
                            let longStr: String = {
                                if let photoLong = item["longitude"].string {
                                    return photoLong as! String
                                }
                                return "Not Found"
                            }()
                            
                            let tagsStr: String = {
                                if let photoTags = item["tags"].string {
                                    return photoTags as! String
                                }
                                return "Not Found"
                            }()
                            
                            //append to local array
                            // photoTitle.append(item["title"].stringValue)
                            // photoURL.append(item["url_z"].stringValue)
                            
                            //self.photoTags.append(item["tags"].stringValue)
                            //self.photoLong.append(item["longtitude"].stringValue)
                            //self.photoLat.append(item["latitude"].stringValue)
                            
                            
                            print("__________________")
                            print(item["title"])
                            print(item["longitude"])
                            print(item["latitude"])
                            print(item["tags"])
                            print(item["url_z"])
                            //append
                            
                            
                            self.photosArray.append(Photos(photoURL: urlStr, photoTitle: titleStr, placeID: placeIDStr, photoLat: latStr, photoLong: longStr, photoTags: tagsStr))
                            
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation(
                    {
                        
                        //update table here....!
                        self.tableView.reloadData()
                })
                
            }
            
        }).resume()
        
    }

    
}
    
    //TO DO
    //function to get 10 images to default feed
    //function to get 10 more new images when scrolled (gesture)

 
