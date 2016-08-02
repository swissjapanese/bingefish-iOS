//
//  BFActor.swift
//  
//
//  Created by Genki Mine on 8/1/16.
//
//

import CoreData
import Alamofire
import Foundation

class BFActor: NSObject
{
    var id: String?
    var name: String?
    var role: String?
    
    convenience init(dictionary: [NSObject: AnyObject])
    {
        self.init()
        
        if let extractor = EBTExtractor(dictionary: dictionary) {
            self.id = extractor.stringForKey("id")
            self.name = extractor.stringForKey("name")
            self.role = extractor.stringForKey("role")
        }
        
        assert(self.id != nil, "id must not be nil")
    }
}
