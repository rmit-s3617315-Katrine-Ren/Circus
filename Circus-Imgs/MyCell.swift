//
//  MyCell.swift
//  Circus-Imgs
//
//  Created by Rita Tse on 22/8/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import Foundation
import UIKit

class MyCell: UITableViewCell, UIAlertViewDelegate
{
    @IBOutlet weak var myImage: UIImageView!;
    @IBOutlet weak var labelRight: UILabel!;

    @IBOutlet weak var likeButton: UIButton!;
    @IBOutlet weak var shareButton: UIButton!;
    @IBOutlet weak var commentButton: UIButton!;
    
    var index: Int!;
    var alertMessage : Alert! = nil
    
    @IBAction func favourite(_ sender: Any) {
        
        var currentPhoto : Photos?
        var pName : String!
        var pUrl : String!
        let flag:Bool! = true
        var currentCard : Card?
        
        //print(Model.get.photosArray.count)
        currentPhoto = Model.get.photosArray[index]
        if let _ = currentPhoto
        {
            pName = currentPhoto!.photoTitle
            pUrl = currentPhoto!.photoURL
        }
        
        //check if the URL already exist in the imageDB
        Model.get.getImageFromCoreData()
        if !Model.get.getURLfromDB().contains(pUrl){
            
        Model.get.saveImage(image_name: pName, image_URL: pUrl, is_Like: flag, existing: currentCard)
            
        }
        
        else {
            alertMessage = UIAlertController(title: "Notice", message:
                "The image has been liked", preferredStyle: UIAlertControllerStyle.alert) as! Alert
            
            alertMessage.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default,handler: nil))
            
            self.alertMessage.present(alertMessage, animated: true, completion: nil)
        }
        print(Model.get.imageDB.count)
   
    }

}
