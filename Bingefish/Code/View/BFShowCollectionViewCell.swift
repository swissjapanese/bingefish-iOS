//
//  BFShowCollectionViewCell.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct BFShowCollectionViewCellSize
{
    static let MinimumWidth: CGFloat = 310.0
    static let MaximumWidth: CGFloat = 350.0
    static let ImageRatioWidth: CGFloat = 300.0
    static let ImageRatioHeight: CGFloat = 169.0
    static let DefaultOverviewHeight: CGFloat = 60.0
    static let DefaultHeightMargins: CGFloat = 40.0
}

class BFShowCollectionViewCell: UICollectionViewCell 
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
        
    // MARK: BFShowCollectionViewCell

    func setUp(show: BFShow)
    {
        titleLabel.text = show.seriesName
        overviewLabel.text = show.overview
        let URL = NSURL(string: show.fanartURLString!)!
        mainImageView.af_setImageWithURL(URL, placeholderImage: UIImage(), filter: nil, imageTransition: .CrossDissolve(0.6))
    }
        
    class func preferredSize(collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, show: BFShow?) -> CGSize
    {
        let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let titleHeight: CGFloat = 22.0
        let collectionViewWidth = CGRectGetWidth(collectionView.frame)
        let numberOfColumns = max(floor(collectionViewWidth / BFShowCollectionViewCellSize.MinimumWidth), 1)
        let sizeMargin = collectionView.contentInset.left + collectionView.contentInset.right
        let cellWidth = (collectionViewWidth / numberOfColumns) - sizeMargin - collectionViewFlowLayout.minimumInteritemSpacing * numberOfColumns
        let imageHeight = cellWidth * BFShowCollectionViewCellSize.ImageRatioHeight / BFShowCollectionViewCellSize.ImageRatioWidth
        var cellHeight: CGFloat = titleHeight + imageHeight + BFShowCollectionViewCellSize.DefaultHeightMargins
        
        if numberOfColumns > 1 {
            cellHeight = cellHeight + BFShowCollectionViewCellSize.DefaultOverviewHeight
        }
        else if let show = show, let overview = show.overview {
            cellHeight = cellHeight + overview.bf_heightWithConstrainedWidth(cellWidth, font: UIFont.systemFontOfSize(14.0))
        }
        
        return CGSize(width: cellWidth, height: cellHeight )
    }
}
