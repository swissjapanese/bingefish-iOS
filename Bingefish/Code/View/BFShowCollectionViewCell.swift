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
    static let MaxWidth = 310.0
}

class BFShowCollectionViewCell: UICollectionViewCell 
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    func setUp(show: BFShow)
    {
        titleLabel.text = show.seriesName
        overviewLabel.text = show.overview
        let URL = NSURL(string: show.fanartURLString!)!
//        let filter = nil
        
        mainImageView.af_setImageWithURL(URL, placeholderImage: UIImage(), filter: nil, imageTransition: .CrossDissolve(0.6))
        
//        Alamofire.request(.GET, show.fanartURLString!).responseImage { [weak self] (response) in
//            if let strongSelf = self, let image = response.result.value  {
//                strongSelf.mainImageView.image = image
//            }
//        }
    }
    
    class func preferredSize(collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout) -> CGSize
    {
        return CGSize(width: BFShowCollectionViewCellSize.MaxWidth, height: 323.0)
    }
}
