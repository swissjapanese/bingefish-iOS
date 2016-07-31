//
//  BFSettingsViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/31/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFSettingsViewController: BFViewController 
{
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        logOutButton.setTitle(NSLocalizedString("LOG_OUT", comment: ""), forState: .Normal)
    }
    
    override func viewWillAppear(animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        if BFUserAuthenticationController.sharedController.isAuthenticated() {
            let user = BFUserAuthenticationController.sharedController.user
            emailAddressLabel.text = user?.emailAddress
        }
    }
    
    override func viewDidAppear(animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        // TODO: Move this logic somewhere else
        
        BFUserAuthenticationController.sharedController.authenticateIfNeeded(includeDoneButton: true, completion: { [weak self] (authenticated) in
            if authenticated {
                dprint("authed")
            }
            else {
                if let tabBarController = self?.tabBarController {
                    tabBarController.selectedViewController = tabBarController.viewControllers![0]
                }
            }
        })
    }
    
    // MARK: Buttons
    
    @IBAction func logOutButtonPressed(sender: AnyObject)
    {
        BFUserAuthenticationController.sharedController.logOut()
        BFUserAuthenticationController.sharedController.authenticateIfNeeded(includeDoneButton: true, completion: { (authenticated) in
            if !authenticated {
                
            }
        })
    }
}
