//
//  MyCell.swift
//  Circus-Imgs
//
//  Created by Rita Tse on 22/8/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import Foundation
import UIKit

class MyCell: UITableViewCell
{
    @IBOutlet weak var myImage: UIImageView!;
    @IBOutlet weak var labelRight: UILabel!;

    @IBOutlet weak var likeButton: UIButton!;
    @IBOutlet weak var shareButton: UIButton!;
    @IBOutlet weak var commentButton: UIButton!;
    
    var currentPhoto : Photos!
    var card : Card? //not finished!
    
    
    @IBAction func favourite(_ sender: Any) {
        if let _ = currentPhoto
        {
           let pName = currentPhoto.photoTitle
           let pUrl = currentPhoto.photoURL
           let flag = true
            
        Model.get.saveImage(image_name: pName, image_URL: pUrl, is_Like: flag, existing: card)
            
        }
        
    }
    //Save button, call model.saveImage(...) here
    
    /**
     var currentPhoto : Photos!
    @IBAction func favourite(_ sender: Any) {
        if let _ = currentPhoto
        {
            Model.get.saveImage(image_name: currentPhoto.photoTitle, image_URL: currentPhoto.photoURL, is_Like: true, existing: <#T##Card?#>)
        }
        
        
        self.navigationController?.popToRootViewController(animated: true)
    } */
    
}
