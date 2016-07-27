//
//  BFShow.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import Foundation
import Alamofire

class BFShow: NSObject 
{
    let tvdbid: String?
    let seriesName: String?
    let overview: String?
    let fanartURLString: String?
    
    init?(dictionary: [String: AnyObject])
    {
        guard let extractor = EBTExtractor(dictionary: dictionary) else {
            return nil
        }
                        
        self.tvdbid = extractor.stringForKey("tvdb_id")
        self.seriesName = extractor.stringForKey("series_name")
        self.overview = extractor.stringForKey("overview")
        self.fanartURLString = extractor.stringForKey("fanart")
        
        super.init()
        
        assert(self.tvdbid != nil, "tvdbid must not be nil")
    }
}
