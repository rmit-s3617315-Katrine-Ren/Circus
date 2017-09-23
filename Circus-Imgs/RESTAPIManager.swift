//
//  Images.swift
//  Circus-Imgs
//
//  Created by Rita Tse on 18/9/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class RESTAPIManager: NSObject {
 
    static let sharedInstance = RESTAPIManager()
    
    let baseURL = "https://api.flickr.com/services"
   
    static let getImagesEndpoint = "/post"
    
    //incomplete - please ignore
    /*
    func getPostWithId(postId: Int, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void)  {
        
        let url : String = baseURL + RESTAPIManager.getImagesEndpoint + String(postId)
        let request : NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in if (error != nil){
        onFailure(error!)
        } else {
            let result = JSON(data: data!)
            onSuccess(result)
            }
        })
        task.resume()
  }
    
    */
    

}
