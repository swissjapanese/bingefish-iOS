//
//  BFShowViewController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/27/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Crashlytics

class BFShowViewController: BFViewController 
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var show: BFShow?
    
    // MARK: - BFShowViewController


    // MARK: - UIViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let show = show {
            titleLabel.text = show.seriesName
            let URL = NSURL(string: show.fanartURLString!)!
            mainImageView.af_setImageWithURL(URL, placeholderImage: UIImage(), filter: nil, imageTransition: .CrossDissolve(0.2))
            overviewLabel.text = show.overview
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}
