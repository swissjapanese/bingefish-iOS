//
//  BFServerController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Alamofire

class BFServerController: NSObject 
{
    var config: BFConfig!
    var operationQueue = NSOperationQueue()
        
    // MARK: Init
    
    override init()
    {
        operationQueue.name = "BFServerController.operationQueue"
        operationQueue.maxConcurrentOperationCount = 5
    }
    
    // MARK: APIs

    func search(query: String, completionHandler: (shows: [BFShow]?, response: Response<AnyObject, NSError>) -> Void)
    {
        let api = "search"
        let parameters = ["query": query]
        request(.GET, api: api, parameters: parameters) { [weak self] response in
            guard let _ = self else {
                return 
            }
            
            var shows = [BFShow]()
            if let json = response.result.value, let array = json as? NSArray {
                for show in array {
                    let show = BFShow(dictionary: show as! [String : AnyObject])
                    shows.append(show)
                }
            }
                
            completionHandler(shows: shows, response: response)
        }
    }
    
    // MARK: Private
    
    private func request(method: Alamofire.Method, api: String!, parameters: [String: String], completionHandler: Response<AnyObject, NSError> -> Void)
    {
        let blockOperation = NSBlockOperation { [weak self] in
            guard let strongSelf = self else {
                return 
            }

            Alamofire.request(method, "\(strongSelf.config.BFConfigMainURL)\(strongSelf.config.BFConfigAPIVersion)\(api)", parameters: parameters)
                .responseJSON { response in
                    completionHandler(response)
            }
        }
        
        operationQueue.addOperation(blockOperation)
    }
}
