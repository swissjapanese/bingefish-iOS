//
//  BFSeason.swift
//  
//
//  Created by Genki Mine on 8/1/16.
//
//

import Foundation
import CoreData

class BFSeason: NSObject 
{
    var episodeCount: NSNumber!
    var seasonID: String?
    var seasonNumber: NSNumber!
    var episodes: [BFEpisode]?

    convenience init(dictionary: [NSObject: AnyObject])
    {
        self.init()
        
        if let extractor = EBTExtractor(dictionary: dictionary) {
            self.episodeCount = extractor.forcedNumberForKey("episode_count")
            self.seasonID = extractor.stringForKey("id")
            self.seasonNumber = extractor.forcedNumberForKey("seasonNumber")
            self.episodes = episodesFromDictionaries(extractor.arrayOfDictionariesForKey("episodes")!)
        }
        
        assert(self.seasonID != nil, "seasonID must not be nil")
    }
    
    func episodesFromDictionaries(dictionaries: [[NSObject: AnyObject]]) -> [BFEpisode]
    {
        var episodes = [BFEpisode]()
        for dictionary in dictionaries {
            episodes.append(BFEpisode(dictionary: dictionary))
        }
        return episodes
    }
}
