//
//  BFFeedViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Crashlytics

class BFFeedViewController: BFViewController, UITableViewDelegate, UITableViewDataSource
{
    enum BFFeedViewControllerSection: Int {
        case BingeInputSection = 0
        case All
    }
    
    let BFFeedShowTableViewCellReuseIdentifier = "BFFeedShowTableViewCellReuseIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var feed: BFFeed?
    
    override func viewDidLoad() 
    {
        #if DEBUG
            feed = BFMockFeed()
        #endif
        
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerNib(UINib(nibName: "BFFeedShowTableViewCell", bundle: nil), forCellReuseIdentifier: BFFeedShowTableViewCellReuseIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) 
    {
        super.viewDidAppear(animated)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return feed!.feeds!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(BFFeedShowTableViewCellReuseIdentifier, forIndexPath: indexPath) as! BFFeedShowTableViewCell
        cell.setUp(feed!.feeds![indexPath.row] as! BFShow)
        return cell
    }
}
