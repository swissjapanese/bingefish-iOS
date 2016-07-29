//
//  BFShow.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import CoreData
import Alamofire
import Foundation

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
    
    // MARK: Core Data stack
    
    init?(manageObject: NSManagedObject)
    {
        self.tvdbid = manageObject.valueForKey("tvdbid") as? String
        self.seriesName = manageObject.valueForKey("seriesName") as? String
        self.overview = manageObject.valueForKey("overview") as? String
        self.fanartURLString = manageObject.valueForKey("fanartURLString") as? String
        
        super.init()
        
        assert(self.tvdbid != nil, "tvdbid must not be nil")
    }
    
    func cacheToCoreData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        guard let managedContext = appDelegate.managedObjectContext else {
            return
        }
        
        if let entity = NSEntityDescription.entityForName("BFShow", inManagedObjectContext: managedContext) {
            let showManageObject = NSManagedObject(entity: entity, insertIntoManagedObjectContext: managedContext)
            showManageObject.setValue(tvdbid, forKey: "tvdbid")
            showManageObject.setValue(seriesName, forKey: "seriesName")
            showManageObject.setValue(overview, forKey: "overview")
            showManageObject.setValue(fanartURLString, forKey: "fanartURLString")
        }
    }

}
