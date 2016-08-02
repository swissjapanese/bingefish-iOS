//
//  BFShowDetail.swift
//  
//
//  Created by Genki Mine on 8/1/16.
//
//

import CoreData
import Alamofire
import Foundation

class BFShowDetail: NSObject 
{
    var genre: String?
    var overview: String?
    var seasonCount: NSNumber?
    var actors: [BFActor]?
    var seasons: [BFSeason]?
    var images: BFShowDetailImages?
    
    // MARK: - Init

    convenience init(dictionary: [String: AnyObject])
    {
        self.init()
        
        if let extractor = EBTExtractor(dictionary: dictionary) {
            self.actors = actorsFromDictionaries(extractor.arrayOfDictionariesForKey("actors")!)
            self.genre = extractor.stringForKey("genre")
            self.overview = extractor.stringForKey("overview")
            self.seasonCount = extractor.numberForKey("season_count")
            self.seasons = seasonsFromDictionaries(extractor.arrayOfDictionariesForKey("seasons")!)
        }
        
        assert(self.overview != nil, "overview must not be nil")
    }
    
    // MARK: - BFShowDetail
    
    func episodeCount() -> Int
    {
        var episodeCount = 0
        if let seasons = seasons {
            for season in seasons {
                episodeCount = episodeCount + season.episodeCount.integerValue
            }
        }
        return episodeCount
    }
    
    // MARK: Private

    
    private func actorsFromDictionaries(dictionaries: [[NSObject: AnyObject]]) -> [BFActor]
    {
        var actors = [BFActor]()
        for dictionary in dictionaries {
            actors.append(BFActor(dictionary: dictionary))
        }
        return actors
    }
    
    private func seasonsFromDictionaries(dictionaries: [[NSObject: AnyObject]]) -> [BFSeason]
    {
        var seasons = [BFSeason]()
        for dictionary in dictionaries {
            seasons.append(BFSeason(dictionary: dictionary))
        }
        return seasons
    }
}
