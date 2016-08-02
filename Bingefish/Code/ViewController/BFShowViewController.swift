//
//  BFShowViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/27/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Crashlytics

class BFShowViewController: BFViewController, UITableViewDelegate, UITableViewDataSource
{
    enum BFShowViewControllerSection: Int {
        case Header = 0
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var show: BFShow?
    var showDetail: BFShowDetail?
    
    // MARK: - BFShowViewController
    
    func episodeForIndexPath(indexPath: NSIndexPath) -> BFEpisode?
    {
        if indexPath.section == BFShowViewControllerSection.Header.rawValue {
            return nil
        }
        else {
            if let showDetail = showDetail, let seasons = showDetail.seasons {
                let season = seasons[indexPath.section - 1]
                return season.episodes![indexPath.row]
            }
        }
        return nil
    }
    
    // MARK: - UIViewController

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200.0
    }

    override func viewWillAppear(animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        guard let showID = show?.showID else {
            return
        }
        
        BFNetworkController.sharedController.fetchShowDetail(showID, completionHandler: { [weak self] (showDetail, response) in
            if let error = response.result.error {
                dprint("\(error)")
            }
            else {
                self?.showDetail = showDetail
                self?.tableView.reloadData()
            }
        })
    }
    
    // MARK: - UITableViewDatasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        }
        else if let showDetail = showDetail, let seasons = showDetail.seasons {
            return seasons[section-1].episodeCount.integerValue
        }
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int 
    {
        var numberOfSections = 1 
        if let showDetail = showDetail, let seasonCount = showDetail.seasonCount {
            numberOfSections = numberOfSections + seasonCount.integerValue
        }
        return numberOfSections
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell
        
        // Header
        if indexPath.section == BFShowViewControllerSection.Header.rawValue && indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("BFShowHeaderTableCellIdentifier")!
            if let show = show, let cell = cell as? BFShowHeaderTableViewCell {
                cell.titleLabel.text = show.seriesName
                let URL = NSURL(string: show.fanartURLString!)!
                cell.headerImageView.af_setImageWithURL(URL, placeholderImage: UIImage(), filter: nil, imageTransition: .CrossDissolve(0.2))
                cell.overviewLabel.text = show.overview
                if let showDetail = showDetail {
                    cell.seasonsLabel.text = String(format: NSLocalizedString("NUMBER_SEASONS", comment: ""), showDetail.seasonCount!) 
                    let episodeCount = showDetail.episodeCount()
                    cell.episodesLabel.text = String(format: NSLocalizedString("NUMBER_EPISODES", comment: ""), "\(episodeCount)") 
                }
                else {
                    cell.seasonsLabel.text = ""
                    cell.episodesLabel.text = ""
                }
            }
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("BFShowEpisodeCellIdentifier")!
            if let _ = showDetail, let cell = cell as? BFShowEpisodeTableViewCell {
                if let episode = episodeForIndexPath(indexPath) {
                    cell.mainLabel.text = "\(episode.episodeNumber). \(episode.episodeName!)"
                }
            }
        }
        
        return cell
    }
}

class BFShowEpisodeTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var mainLabel: UILabel!
}
