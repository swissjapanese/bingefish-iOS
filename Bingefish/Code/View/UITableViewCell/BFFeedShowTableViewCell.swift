//
//  BFFeedShowTableViewCell.swift
//  Bingefish
//
//  Created by Genki Mine on 8/28/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFFeedShowTableViewCell: UITableViewCell 
{    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    func setUp(show: BFShow)
    {
        titleLabel.text = show.seriesName
        overviewLabel.text = show.overview
        let URL = NSURL(string: show.fanartURLString!)!
        mainImageView.af_setImageWithURL(URL, placeholderImage: UIImage(), filter: nil, imageTransition: .CrossDissolve(0.6))
    }
}
