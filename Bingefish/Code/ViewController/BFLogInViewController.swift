//
//  BFLogInViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/31/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFLogInViewController: BFViewController
{
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var completion: ((Bool) -> Void)?

    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        logInLabel.text = NSLocalizedString("LOG_IN", comment: "")
        emailAddressTextField.placeholder = NSLocalizedString("EMAIL_ADDRESS", comment: "")
        passwordTextField.placeholder = NSLocalizedString("PASSWORD", comment: "")
        logInButton.setTitle(NSLocalizedString("LOG_IN", comment: ""), forState: .Normal)
        forgotPasswordButton.setTitle(NSLocalizedString("FORGOT_PASSWORD", comment: ""), forState: .Normal)
        
        logInButton.backgroundColor = UIColor.bf_tintColor()
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject)
    {
        if let emailAddress = emailAddressTextField.text {
            BFUserAuthenticationController.sharedController.logIn(emailAddress, password: "", viewController: self, completion: completion)
        }
    }
}
