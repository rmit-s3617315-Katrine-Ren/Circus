//
//  MessageViewController.swift
//  Circus_Comments
//
//  Created by MACBOOK on 23/8/17.
//  Copyright © 2017 Kaixin Ren. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet var messageView : UITableView!
    @IBOutlet weak var msgTextfield: UITextField!
    @IBOutlet weak var msgSend: UIButton!
    
    var defaultConstraintValue: CGFloat = 0;
     
     @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        defaultConstraintValue = bottomConstraint.constant;
         
         
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView)-> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int
    {
        return Model.get.chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MessageCell
        
        
        if(Model.get.chat[indexPath.row].type ==  .messageIn)
        {
            cell.messageIn.text = Model.get.chat[indexPath.row].text
            cell.messageOut.isHidden = true
            cell.chatBubbleOut.isHidden = true
            cell.profile.image = UIImage(named: "image4")
        }
        else
        {
            cell.messageOut.text = Model.get.chat[indexPath.row].text
            cell.messageIn.isHidden = true
            cell.chatBubbleIn.isHidden = true
        }
        
        return cell
    }
    
    //keyboard control
    func keyboardShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
         {
             print("keyboard height!! \(keyboardSize.height)");
             bottomConstraint.constant = keyboardSize.height + defaultConstraintValue + 44;
             UIView.animate(withDuration: 0.1)
             {
                 self.view.layoutIfNeeded()
            }
            print("keyboard show!! \(bottomConstraint.constant)");
        }
    }
    
    func keyboardHide(notification: NSNotification) {
         
             bottomConstraint.constant = defaultConstraintValue;
             UIView.animate(withDuration: 0.1)
             {
                 self.view.layoutIfNeeded()
             }
             print("keyboard hide!! \(bottomConstraint.constant)");
         }
}
