//
//  BFViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/27/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Crashlytics

class BFViewController: UIViewController 
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool) 
    {
        super.viewDidAppear(animated)

        CLSLogv("\(self.dynamicType) \(#function):\(#line)", getVaList([]))
    }
    
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
