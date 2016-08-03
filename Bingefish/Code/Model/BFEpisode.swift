//
//  BFEpisode.swift
//  
//
//  Created by Genki Mine on 8/1/16.
//
//

import Foundation
import CoreData

class BFEpisode: NSObject
{
    var overview: String?
    var episodeName: String?
    var episodeNumber = NSNumber()
    
    convenience init(dictionary: [NSObject: AnyObject])
    {
        self.init()
        
        if let extractor = EBTExtractor(dictionary: dictionary) {
            self.episodeName = extractor.stringForKey("episode_name") ?? "(episode name missing)"
            self.episodeNumber = extractor.numberForKey("episode_number")!
        }
    }
}
