//
//  BFUserAuthenticationController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/31/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import SAMKeychain

class BFUserAuthenticationController: NSObject 
{
    static let sharedController = BFUserAuthenticationController()
    
    let BFUserAuthenticationControllerKeychainEmailAddress = "BFUserAuthenticationControllerKeychainEmailAddress"
    let BFUserAuthenticationControllerServiceEmailAddress = "BFUserAuthenticationControllerServiceEmailAddress"
    
    private let keychain = SAMKeychain()
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
        SAMKeychain.deletePasswordForService(BFUserAuthenticationControllerServiceEmailAddress, account: account())
        user = nil
    }
    
    func isAuthenticated() -> Bool
    {
        return user != nil
    }
    
    private func userDidLogIn(user: BFUser)
    {
        self.user = user
        
        SAMKeychain.setPassword(user.emailAddress, forService: BFUserAuthenticationControllerServiceEmailAddress, account: account())
    }
    
    private func emailAddress() -> String?
    {
        if let emailAddress = SAMKeychain.passwordForService(BFUserAuthenticationControllerServiceEmailAddress, account: account()) {
            return emailAddress
        }
        
        return nil
    }
    
    private func account() -> String
    {
        return "DefaultAccount"
    }
}
