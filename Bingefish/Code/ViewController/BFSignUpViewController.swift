//
//  BFSignUpViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/31/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFSignUpViewController: BFViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var completion: ((Bool) -> Void)?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        signUpLabel.text = NSLocalizedString("SIGN_UP", comment: "")
        welcomeLabel.text = NSLocalizedString("WELCOME_TO_BINGEFISH", comment: "")
        facebookButton.setTitle(NSLocalizedString("SIGN_UP_WITH_FACEBOOK", comment: ""), forState: .Normal)
        orLabel.text = NSLocalizedString("OR", comment: "")
        emailAddressTextField.placeholder = NSLocalizedString("EMAIL_ADDRESS", comment: "")
        passwordTextField.placeholder = NSLocalizedString("PASSWORD", comment: "")
        signUpButton.setTitle(NSLocalizedString("SIGN_UP", comment: ""), forState: .Normal)
        alreadyHaveAccountLabel.text = NSLocalizedString("ALREADY_HAVE_ACCOUNT", comment: "")
        logInButton.setTitle(NSLocalizedString("LOG_IN", comment: ""), forState: .Normal)
        
        signUpButton.backgroundColor = UIColor.bf_tintColor()
        emailAddressTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        emailAddressTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        passwordTextField.layer.borderWidth = 0.5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        if let completion = completion {
            completion(BFUserAuthenticationController.sharedController.isAuthenticated())
        }
    }
    
    // MARK: Buttons
    
    @IBAction func signUpButtonPressed(sender: AnyObject) 
    {
        if let emailAddress = emailAddressTextField.text {
            if BFHelper.isValidEmail(emailAddress) {
                BFUserAuthenticationController.sharedController.signUp(emailAddress, password: "", viewController: self, completion: completion)                
            }
            else {
                
            }
        }
    }
    
    // MARK: NSNotifications
    
    func keyboardWillChangeFrame(notification: NSNotification)
    {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame?.origin.y >= CGRectGetHeight(UIScreen.mainScreen().bounds) {
                bottomConstraint.constant = 0.0
            } 
            else {
                bottomConstraint.constant = -CGRectGetHeight(endFrame!) ?? 0.0
            }
            
            UIView.animateWithDuration(duration,
                                       delay: NSTimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
}
