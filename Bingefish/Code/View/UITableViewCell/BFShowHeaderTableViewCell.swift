//
//  BFShowHeaderTableViewCell.swift
//  Bingefish
//
//  Created by Genki Mine on 8/1/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFShowHeaderTableViewCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        if gradientLayer == nil {
            let gradient: CAGradientLayer = CAGradientLayer()
            let startColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
            let endColor = UIColor(white: 0.0, alpha: 0.0)
            gradient.colors = [startColor.CGColor, endColor.CGColor]
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.8, y: 1.0)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
            headerImageView.layer.insertSublayer(gradient, atIndex: 0)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) 
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
