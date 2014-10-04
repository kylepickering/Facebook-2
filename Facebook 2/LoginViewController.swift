//
//  LoginViewController.swift
//  Facebook 2
//
//  Created by Kyle Pickering on 9/17/14.
//  Copyright (c) 2014 Kyle Pickering. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onLoginButton(sender: AnyObject) {
        loadingActivity.startAnimating()
        loginButton.selected = true
        delay(2, closure: { () -> () in
            
            self.loadingActivity.stopAnimating()
            self.loginButton.selected = false
            
            if self.emailTextField.text == "" || self.passwordTextField == "" {
                UIAlertView(title: "Oh no!", message: "That's too bad...", delegate: nil, cancelButtonTitle: "Try again...").show()
            } else {
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            
        })
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
