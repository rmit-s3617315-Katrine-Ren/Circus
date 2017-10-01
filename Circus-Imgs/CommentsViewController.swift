//
//  ViewController.swift
//  Circus-Imgs
//
//  Created by Samuel Fary on 21/8/17.
//  Copyright © 2017 s3419529. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var defaultConstraintValue: CGFloat = 0;

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    @IBOutlet var commentView: UITableView!
    @IBOutlet weak var commentsTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        defaultConstraintValue = bottomConstraint.constant;

        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func numberOfSections(in tablView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.get.users.count;
    }
    
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> UITableViewCell {
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsFD", for: indexPath) as! CommentsCell
        
        cell.commentBox?.text = Model.get.comments[indexPath.row];
        
        cell.profileImg.image = UIImage(named: Model.get.users[indexPath.row])
        
        
        return cell
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.commentsTextfield = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.commentsTextfield = textField
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
    
    func keyboardHide(notification: NSNotification)
    
    {
        bottomConstraint.constant = defaultConstraintValue;
        UIView.animate(withDuration: 0.1)
        {
            self.view.layoutIfNeeded()
        }
        print("keyboard hide!! \(bottomConstraint.constant)");
    }
    




}

