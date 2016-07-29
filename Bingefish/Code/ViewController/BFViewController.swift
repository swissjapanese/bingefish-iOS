//
//  BFViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/27/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

extension UIViewController 
{
    func embedInNavigationController(includeDoneButton includeDoneButton: Bool) -> UINavigationController
    {
        let navigationController = UINavigationController(rootViewController: self)
        if includeDoneButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneButtonItemPressed(_:)))
        }
        return navigationController
    }
    
    @objc func doneButtonItemPressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
