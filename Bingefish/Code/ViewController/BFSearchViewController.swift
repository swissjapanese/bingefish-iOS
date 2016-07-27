//
//  BFSearchViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating 
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarBackgroundView: UIView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let BFShowCollectionViewCellReuseIdentifier = "BFShowCollectionViewCellReuseIdentifier"
    
    var shows: [BFShow]?

    // MARK: - BFSearchViewController

    func searchString(string: String)
    {
        BFApp.sharedInstance.serverController.search(string) { [weak self] (shows, response)  in
            if let error = response.result.error {
                print("\(error)")
            }
            else {
                self?.shows = shows
                self?.collectionView?.reloadData()
            }
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
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UICollectionViewController
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let view = UICollectionReusableView()
        view.addSubview(searchController.searchBar)
        return view
    }
    
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
        return BFShowCollectionViewCell.preferredSize(collectionView, collectionViewLayout: collectionViewLayout)
    }
    
    // MARK: - UISearchResultUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if let text = searchController.searchBar.text {
            searchString(text)
        }
    }
    
}
