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

class BFShow: NSManagedObject 
{
    convenience init(dictionary: [String: AnyObject])
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext        
        let entity = NSEntityDescription.entityForName("BFShow", inManagedObjectContext: managedObjectContext!)
        self.init(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if let extractor = EBTExtractor(dictionary: dictionary) {
            self.showID = extractor.stringForKey("tvdb_id")
            self.seriesName = extractor.stringForKey("series_name")
            self.overview = extractor.stringForKey("overview")
            self.fanartURLString = extractor.stringForKey("fanart")
        }
                
        assert(self.showID != nil, "showID must not be nil")
    }
        
    func cacheToCoreData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        guard let managedContext = appDelegate.managedObjectContext else {
            return
        }
        
        if let entity = NSEntityDescription.entityForName("BFShow", inManagedObjectContext: managedContext) {
            let showManageObject = NSManagedObject(entity: entity, insertIntoManagedObjectContext: managedContext)
            showManageObject.setValue(showID, forKey: "showID")
            showManageObject.setValue(seriesName, forKey: "seriesName")
            showManageObject.setValue(overview, forKey: "overview")
            showManageObject.setValue(fanartURLString, forKey: "fanartURLString")
        }
    }

}
