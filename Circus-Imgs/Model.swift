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

class Model
{
    static var get: Model = Model()
    
    private init()
    {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Get a reference to AppDeLegate
    let appDelegate = UIApplication.shared.delegate as!AppDelegate
    
    //Hold a reference to Managed Context
    let managedContext: NSManagedObjectContext
    
    //Create a collection of object to store in database
    var imageDB = [Image]()
    
    //retrieves the image as a 'Image' object and not an 'NSManagedObject'
    func getImage(_ indexPath:IndexPath)->Image
    {
        return imageDB[indexPath.row]
    }
    
    
    // MARK : CRUD
    
    // U: tackle updating in core data
    func updateDatabase(){
        do{
            try managedContext.save()}
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
            let fetchResult = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
            let results = try managedContext.fetch(fetchResult)
            imageDB = results as! [Image]
            
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    // C: create record in core data
    func saveImage(image_name:String, image_URL:String, is_Like:Bool, existing:Image?)
    {
        let myEntity = NSEntityDescription.entity(forEntityName: "Image", in: managedContext)!
        
        //if existing is not nill then keep updating the moive
        if let _ = existing
        {
            existing!.imageName = image_name
            existing!.imageURL = image_URL
            existing!.isLike = is_Like
        }
            
            //create a new image object and update it with the data pass-in from the View Controler
        else{
            
            let newImage = Image(entity: myEntity, insertInto: managedContext)
            
            if(image_name == ""){
            
                newImage.imageName = "default"
            }
            else{
                
            newImage.setValue(image_name, forKey: "imageName")
                
            }
            
            newImage.setValue(image_URL, forKey: "imageURL")
            newImage.setValue(is_Like, forKey: "isLike")
            imageDB.append(newImage)
        
        updateDatabase()
    }
    
}



    /** data for old version*/
    
    var images: [String] = ["mushroom", "xanaduhouses", "londonolympics"]
    
    var users: [String] = ["user1", "user2"]
    
    var comments: [String] = ["Comment 1", "Dummy Comment 2", "Hahaha #YOLO"]
    
    var search: [String] = ["#cats", "#yasqueen", "#yesyesnono", "#emotionalclub"]
    
    var chat:[Message]=[Message(text: "How was the party? ", type: .messageIn),Message(text: "That was crazy hahaha!!", type: .messageOut), Message(text: "Sounds Awesome!!", type: .messageIn), Message(text: "You should come with us.", type: .messageOut)]
 
     
}
