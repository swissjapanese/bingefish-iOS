//
//  BFSearchViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFSearchViewController: UIViewController 
{
    override func viewDidLoad() 
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        BFApp.sharedInstance.serverController.search("throne") { (shows, response) in
            
        }
    }
}
