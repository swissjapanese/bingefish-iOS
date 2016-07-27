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
    
    // MARK: APIs
    
    func search(query: String, completionHandler: (shows: [BFShow]?, response: Response<AnyObject, NSError>) -> Void)
    {
        let api = "search"
        let parameters = ["query": query]
        request(.GET, api: api, parameters: parameters) { response in
            var shows = [BFShow]()
            if let json = response.result.value {
                if let array = json as? NSArray {
                    for show in array {
                        if let show = BFShow(dictionary: show as! [String : AnyObject]) {
                            shows.append(show)
                        }
                    }
                }
            }
                
            completionHandler(shows: shows, response: response)
        }
    }
    
    // MARK: Private
    
    private func request(method: Alamofire.Method, api: String!, parameters: [String: String], completionHandler: Response<AnyObject, NSError> -> Void)
    {
        Alamofire.request(method, "\(config.BFConfigMainURL)\(config.BFConfigAPIVersion)\(api)", parameters: parameters)
            .responseJSON { response in
                completionHandler(response)
        }
    }
}
