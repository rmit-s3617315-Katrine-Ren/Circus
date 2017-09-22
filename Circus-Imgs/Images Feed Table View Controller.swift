//
//  Images Feed Table View Controller.swift
//  Circus-Imgs
//
//  Created by Rita Tse on 21/8/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import UIKit

class ImagesFeedTableViewController: UITableViewController {
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.contentInset = UIEdgeInsetsMake(30,0,0,0)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns array of images from model
        return Model.get.images.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageFD", for: indexPath) as! MyCell
        
        //image description
        cell.labelRight?.text = Model.get.images[indexPath.row];
       
        //image
        cell.myImage.image = UIImage(named: Model.get.images[indexPath.row])
        
        return cell
    }
    
    
    //function to get 5 images to default feed
    
    //function to get 10 more new images when scrolled (gesture)
    
    
    /*
    
    //https://medium.com/@petrosdemetrakopoulos/creating-a-rest-api-manager-in-swift-4cd610699bed
    func getRESTData(){
        
        RESTAPIManager.sharedInstance.getPostWithId(postId: 1, onSuccess: { json in
            DispatchQueue.main.async {
                cell.myImage?.image = UIImage(describing: json)//String(describing: json) //change String to img
            }
            }, onFailure: { error in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert) alert.addAction(UIAlertAction(title: "Dismiss", style: .default,  handler: nil))
            self.show(alert, sender: nil)
        })
        }
*/
}
