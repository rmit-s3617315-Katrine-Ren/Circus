//
//  SavedImageViewController.swift
//  Circus-Imgs
//
//  Created by MACBOOK on 24/9/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import Foundation
import UIKit

class SavedImageViewController: UITableViewController{
    
    var model = Model.get
    
    // MARK: - Prepare data for display
    // Make sure the latest data is displayed when the view is displayed
    override func  viewDidAppear(_ animated: Bool)
    {
        self.tableView.reloadData()
    }
    
    // Just prior to the view appearing, get the latest copy of movies from the model
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        model.getImageFromCoreData()
    }

    
    // MARK: - Populate the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.imageDB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedImageCell", for: indexPath) as UITableViewCell
        
        let display = model.getImage(indexPath)
        cell.textLabel!.text = display.imageName
        cell.imageView!.image = UIImage(named: display.imageName!)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // MARK: - Enable Swipe to Delete
    // System method that enables swipe to delete on a row in a tableview controller.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    // System method that gets called when delete is selected
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        model.deleteImage(indexPath)
        //model.imageDB.remove(at: indexPath.row)
        
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }

    
    
    // MARK: - Table view system methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
