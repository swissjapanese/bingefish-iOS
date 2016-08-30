//
//  BFMockFeed.swift
//  
//
//  Created by Genki Mine on 8/1/16.
//
//

import CoreData
import Alamofire
import Foundation

class BFMockFeed: BFFeed
{
    override init()
    {
        super.init()
        
        setUp()
    }
    
    func setUp()
    {
        self.feeds = [AnyObject]()
        
        var show =  
            showForDictionary([
                "tvdb_id" : "305288",
                "overview" : "When a young boy disappears, his mother, a sheriff, and his friends must confront terrifying forces in... [read more]",
                "fanart" : "https://bingie-prod.s3-us-west-2.amazonaws.com/show/fanart/305288/thumb_9f31b8bf30.jpg",
                "series_name" : "Stranger Things",
            ])
        feeds?.append(show)
        
        show = showForDictionary([
                "tvdb_id" : "291717",
                "overview" : "When a young boy disappears, his mother, a sheriff, and his friends must confront terrifying forces in... [read more]",
                "fanart" : "https://bingie-prod.s3-us-west-2.amazonaws.com/show/fanart/305288/thumb_9f31b8bf30.jpg",
                "series_name" : "Stranger But True",
            ]
        )
        feeds?.append(show)

        show = showForDictionary([
                "tvdb_id" : "79429",
                "overview" : "George lives to find new things to discover, touch, spill, and chew. Everything is new to George and... [read more]",
                "fanart" : "https://bingie-prod.s3-us-west-2.amazonaws.com/show/fanart/79429/thumb_338037822f.jpg",
                "series_name" : "Curious George",
            ]
        )
        feeds?.append(show)
    }
    
    func showForDictionary(dictionary: [String: AnyObject]) -> BFShow
    {
        return BFShow(dictionary: dictionary)
    }
}
