//
//  BFSearchViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import CoreData
import Crashlytics

class BFSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating 
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarBackgroundView: UIView!
    
    let BFShowCollectionViewCellReuseIdentifier = "BFShowCollectionViewCellReuseIdentifier"
    let BFSearchViewControllerearchTimeThreshold: NSTimeInterval = 1.5

    let searchController = UISearchController(searchResultsController: nil)
    let searchOperationQueue = NSOperationQueue()

    var shows: [BFShow]?
    var previouslySearchedTime = NSDate().timeIntervalSince1970
    var queuedQueries = [String]()
    
    required init?(coder aDecoder: NSCoder)
    {
        searchOperationQueue.name = "\(NSStringFromClass(self.dynamicType)).searchOperationQueue"
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - BFSearchViewController

    func searchString(string: String)
    {
        if string.isEmpty {
            return
        }
        
        // Add search string to array and only do the search when BFSearchViewControllerearchTimeThreshold seconds have passed to avoid search spamming the server
        
        queuedQueries.append(string)
        
        let now = NSDate().timeIntervalSince1970
        let searchableTimeInterval = previouslySearchedTime + BFSearchViewControllerearchTimeThreshold

        if searchableTimeInterval > now {
            dispatchAfterInDefaultQueue(BFSearchViewControllerearchTimeThreshold, closure: { [weak self] in
                self?.performSearchQueue()
            })
        }
        else {
            performSearchQueue()
        }
    }
    
    func performSearchQueue()
    {
        searchOperationQueue.cancelAllOperations()
        
        guard let string = queuedQueries.last else {
            return
        }
        
        let blockOperation = NSBlockOperation { 
            BFNetworkController.sharedController.search(string) { [weak self] (shows, response)  in
                if let error = response.result.error {
                    dprint("\(error)")
                }
                else {
                    if let strongSelf = self {
                        strongSelf.previouslySearchedTime = NSDate().timeIntervalSince1970
                        strongSelf.shows = shows
                        strongSelf.collectionView?.reloadData()
                        strongSelf.cacheShowsToCoreData()
                        NSUserDefaults.standardUserDefaults().setObject(string, forKey: NSUserDefaultsPreviousSearchedStringKey)
                    }
                }
            }
        }
        
        searchOperationQueue.addOperation(blockOperation)
        queuedQueries.removeAll()
    }
    
    func cacheShowsToCoreData()
    {
        guard let shows = shows where shows.count > 0 else {
            return
        }
        
        for show in shows {
            show.cacheToCoreData()
        }
    }
    
    func readShowsFromCoreData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "BFShow")
    
        do {
            let results = try managedContext!.executeFetchRequest(fetchRequest)
            let manageObjectShows = results as! [NSManagedObject]
            if shows == nil {
                shows = [BFShow]()
            }

            for manageObjectShow in manageObjectShows {
                if let show = manageObjectShow as? BFShow {
                    shows!.append(show)                    
                }
            }
            
            if shows!.count > 0 {
                self.collectionView?.reloadData()
                searchController.searchBar.text = NSUserDefaults.standardUserDefaults().objectForKey(NSUserDefaultsPreviousSearchedStringKey) as? String
                searchController.searchBar.becomeFirstResponder()
            }
        } 
        catch let error as NSError {
            dprint("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchBarBackgroundView.addSubview(searchController.searchBar)
        
        collectionView!.registerNib(UINib(nibName: "BFShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BFShowCollectionViewCellReuseIdentifier)
        
        readShowsFromCoreData()
    }
    
    override func viewDidAppear(animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        CLSLogv("\(self.dynamicType) \(#function):\(#line)", getVaList([]))
    }
    
    // MARK: - UICollectionViewController
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int 
    {
        if let shows = shows {
            return shows.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell 
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(BFShowCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as? BFShowCollectionViewCell
        
        if cell == nil {
            cell = BFShowCollectionViewCell()
        }
        
        if let show = shows?[indexPath.row] {
            cell?.setUp(show)
        }
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize 
    {
        return BFShowCollectionViewCell.preferredSize(collectionView, collectionViewLayout: collectionViewLayout, show: shows?[indexPath.row])
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) 
    {
        let storyboard = UIStoryboard(name: "Show", bundle: nil)
        if let showViewController = storyboard.instantiateViewControllerWithIdentifier("BFShowViewControllerID") as? BFShowViewController {
            showViewController.show = shows?[indexPath.row]
            
            if BFHelper.isIPhoneOrIPod() {
                self.navigationController?.pushViewController(showViewController, animated: true)
            }
            else if BFHelper.isIPad() {
                let navigationController = showViewController.embedInNavigationController(includeDoneButton: true)
                navigationController.modalPresentationStyle = .FormSheet
                self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UISearchResultUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if let text = searchController.searchBar.text {
            searchString(text)
        }
    }
}
