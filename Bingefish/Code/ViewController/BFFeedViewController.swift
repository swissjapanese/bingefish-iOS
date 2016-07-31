//
//  BFFeedViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Crashlytics

class BFFeedViewController: UIViewController 
{
    override func viewDidLoad() 
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        CLSLogv("\(self.dynamicType) \(#function):\(#line)", getVaList([]))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
