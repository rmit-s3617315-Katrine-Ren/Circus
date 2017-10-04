//
//  Model.swift
//  Circus-Imgs
//
//  Created by Samuel Fary on 22/8/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

//Rest API KEY Goes here
let apiKey = "c21fa3df81455afb0cd447e13ea34179"


class Model
{
    static var get:Model = Model()
    

    private init()
    {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Get a reference to AppDeLegate
    let appDelegate = UIApplication.shared.delegate as!AppDelegate
    
    //Hold a reference to Managed Context
    let managedContext: NSManagedObjectContext
    
    //Create a collection of object to store in database
    var imageDB = [Card]()
    
    //retrieves the image as a 'Image' object and not an 'NSManagedObject'
    func getImage(_ indexPath:IndexPath)->Card
    {
        return imageDB[indexPath.row]
    }
    
    //retrieves the URLs of image in core data
    func getURLfromDB() -> [String]
    {
        var urlList = [String]()
        for savedPhoto in imageDB {
            
            urlList.append(savedPhoto.imageURL!)
        }
        
        return urlList
    }
    
    
    
    
    
    // MARK : CORE DATA PART --CRUD
    
    // U: tackle updating in core data
    func updateDatabase(){
        do{
            try managedContext.save()
            
        }
        catch let error as NSError{
            print ("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    // D: tackle deleting from core data
    func deleteImage (_ indexPath: IndexPath) {
        let movie = imageDB[indexPath.item]
        imageDB.remove(at: indexPath.item)
        managedContext.delete(movie)
        updateDatabase()
    }
    
    
    // R: tackle retrieving from core data
    func getImageFromCoreData()
    {
        do{
            let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
            let results = try managedContext.fetch(fetchResult)
            imageDB = results as! [Card]
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    // C: create record in core data
    func saveImage(image_name:String, image_URL:String, is_Like:Bool, existing:Card?)
    {
        //let myEntity = NSEntityDescription.entity(forEntityName: "Card", in: managedContext)!
        
        //if existing is not nill then keep updating the moive
        if let _ = existing
        {
            existing!.imageName = image_name
            existing!.imageURL = image_URL
            existing!.isLike = is_Like
        }
            
            //create a new card object and update it with the data pass-in from the View Controler
        else{
            
            let newCard = Card(context: managedContext)
            
            if(image_name == ""){
            
                newCard.imageName = "default"
            }
            else{
                
            newCard.setValue(image_name, forKey: "imageName")
                
            }
            
            newCard.setValue(image_URL, forKey: "imageURL")
            newCard.setValue(is_Like, forKey: "isLike")
            imageDB.append(newCard)
        
        updateDatabase()
    }
    
}


   
    // MARK : REST API Part

    //REST API Call - move to Model
    final let urlString = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=\(apiKey)&extras=geo%2C+tags%2C+machine_tags%2C+url_z&format=json&nojsoncallback=1"
    
    //create Photos array from Model
    var photosArray = [Photos]()
    
    var allTags = String()
    
    
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
                                return "0"
                            }()
                            
                            let longStr: String = {
                                if let photoLong = item["longitude"].string {
                                    return photoLong as! String
                                }
                                return "0"
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
                            
                            
                            //print to console
                            print("__________________")
                            print(item["title"])
                            print(item["longitude"])
                            print(item["latitude"])
                            print(item["tags"])
                            print(item["url_z"])
                            
                            //appending to Photos Array
                            self.photosArray.append(Photos(photoURL: urlStr, photoTitle: titleStr, placeID: placeIDStr, photoLat: latStr, photoLong: longStr, photoTags: tagsStr))
                            
                            //append to Tags Array
                            self.allTags.append(tagsStr)
                            self.allTags.append(" ")
                            
                            
                        }
                    }
                }
                
                //sends notification
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: dataModelDidUpdateNotif), object: nil)
            }
            
        }).resume()
        
    }
    
    // MARK : LEGACY DUMMY DATA PART
    
    /** data for assignemnt1 **/
    var images: [String] = ["mushroom", "xanaduhouses", "londonolympics"]
    
    var users: [String] = ["user1", "user2"]
    
    var comments: [String] = ["Comment 1", "Dummy Comment 2", "Hahaha #YOLO"]
    
    var search: [String] = ["#cats", "#yasqueen", "#yesyesnono", "#emotionalclub"]
    
    var chat:[Message]=[Message(text: "How was the party? ", type: .messageIn),Message(text: "That was crazy hahaha!!", type: .messageOut), Message(text: "Sounds Awesome!!", type: .messageIn), Message(text: "You should come with us.", type: .messageOut)]
    
}//END OF CLASS


//Struct for Photo Objects
struct Photos {
    
    let photoURL : String
    let photoTitle : String
    let placeID : String
    let photoLat : String
    let photoLong : String
    let photoTags: String
    
    
    init (photoURL:String, photoTitle:String, placeID:String, photoLat:String, photoLong:String, photoTags:String) {
        self.photoURL = photoURL
        self.photoTitle = photoTitle
        self.placeID = placeID
        self.photoLat = photoLat
        self.photoLong = photoLong
        self.photoTags = photoTags
        
    }
}
