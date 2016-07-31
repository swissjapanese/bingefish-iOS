//
//  BFUserAuthenticationController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/31/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFUserAuthenticationController: NSObject 
{
    static let sharedController = BFUserAuthenticationController()
    
    let BFUserAuthenticationControllerKeychainEmailAddress = "BFUserAuthenticationControllerKeychainEmailAddress"
    
    private let keychainWrapper = KeychainWrapper()
    var user: BFUser?
    
    override init()
    {
        super.init()
        
        // Load keychain user if needed
        if let emailAddress = emailAddress() {
            let user = BFUser()
            user.emailAddress = emailAddress
            self.user = user
        }
    }
    
    func authenticateIfNeeded(includeDoneButton includeDoneButton: Bool, completion: ((authenticated: Bool) -> Void)?)
    {
        if user == nil && completion != nil {
            if let topController = BFHelper.topViewController() {
                let signUpViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() as! BFSignUpViewController
                signUpViewController.completion = completion
                let navigationController = signUpViewController.embedInNavigationController(includeDoneButton: includeDoneButton)
                if BFHelper.isIPad() {
                    navigationController.modalPresentationStyle = .FormSheet
                }
                topController.presentViewController(navigationController, animated: true, completion: nil)
            }
        }
        else {
            if let completion = completion {
                completion(authenticated: true)
            }
        }
    }
    
    func signUp(emailAddress: String, password: String, viewController: UIViewController, completion: ((Bool) -> Void)?)
    {
        BFNetworkController.sharedController.signUp(emailAddress, password: "") { [weak self] (user, response) in
            // TODO: Check for error
            let error = false
            if (error) {
                
            }
            else {
                if let user = user {
                    self?.userDidLogIn(user)
                    viewController.dismissViewControllerAnimated(true, completion: { 
                        if let completion = completion {
                            completion(true)
                        }
                    })
                }
            }
        }
    }
    
    func logIn(emailAddress: String, password: String, viewController: UIViewController, completion: ((Bool) -> Void)?)
    {
        BFNetworkController.sharedController.signUp(emailAddress, password: "") { [weak self] (user, response) in
            // TODO: Check for error
            let error = false
            if (error) {
                
            }
            else {
                if let user = user {
                    self?.userDidLogIn(user)
                    viewController.dismissViewControllerAnimated(true, completion: { 
                        if let completion = completion {
                            completion(true)
                        }
                    })
                }
            }
        }
    }
    
    func logOut()
    {
        self.user = nil
        keychainWrapper.mySetObject("", forKey: kSecAttrAccount)
        keychainWrapper.writeToKeychain()
    }
    
    func isAuthenticated() -> Bool
    {
        return user != nil
    }
    
    private func userDidLogIn(user: BFUser)
    {
        self.user = user
        setEmailAddress(user.emailAddress)
    }
    
    private func setEmailAddress(emailAddress: String)
    {
        keychainWrapper.mySetObject(emailAddress, forKey:kSecAttrAccount)
        keychainWrapper.writeToKeychain()
    }
    
    private func emailAddress() -> String?
    {
        if let emailAddress = keychainWrapper.myObjectForKey(kSecAttrAccount) as? String {
            if emailAddress == "Account" { // Somehow, instead of nil, I get "Account" for default value
                return nil
            }
            else {
                return emailAddress
            }
        }
        
        return nil
    }
}
