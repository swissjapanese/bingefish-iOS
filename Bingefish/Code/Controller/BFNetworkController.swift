//
//  BFNetworkController.swift
//  Bingefish
//
//  Created by Genki Mine on 7/26/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import Alamofire

class BFNetworkController: NSObject 
{
    static let sharedController = BFNetworkController()
    
    var config: BFConfig!
    var operationQueue = NSOperationQueue()
        
    // MARK: Init
    
    override init()
    {
        operationQueue.name = "\(NSStringFromClass(self.dynamicType)).operationQueue"
        operationQueue.maxConcurrentOperationCount = 5
        
        // For USA, use main BFConfig
        config = BFConfig()
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
    
    func signUp(emailAddress: String, password: String, completionHandler: (user: BFUser?, response: Response<AnyObject, NSError>?) -> Void)
    {
        // Fake user until we have API
        let user = BFUser()
        user.emailAddress = emailAddress
        completionHandler(user: user, response: nil)
    }
    
    func signIn(emailAddress: String, password: String, completionHandler: (user: BFUser?, response: Response<AnyObject, NSError>?) -> Void)
    {
        // Fake user until we have API
        let user = BFUser()
        user.emailAddress = emailAddress
        completionHandler(user: user, response: nil)
    }
    
    func fetchShowDetail(id: String, completionHandler: (showDetail: BFShowDetail?, response: Response<AnyObject, NSError>) -> Void)
    {
        let api = "shows/\(id)"
        request(.GET, api: api, parameters: nil) { [weak self] response in
            guard let _ = self else {
                return 
            }
            
            var showDetail: BFShowDetail?
            
            if let json = response.result.value, let dictionary = json as? [String : AnyObject] {
                showDetail = BFShowDetail(dictionary: dictionary)
            }
            
            completionHandler(showDetail: showDetail, response: response)
        }
    }
    
    // MARK: Private
    
    private func request(method: Alamofire.Method, api: String!, parameters: [String: String]?, completionHandler: Response<AnyObject, NSError> -> Void)
    {
        let blockOperation = NSBlockOperation { [weak self] in
            guard let strongSelf = self else {
                return 
            }
            
            let baseURL = "\(strongSelf.config.BFConfigMainURL)\(strongSelf.config.BFConfigAPIPath)"
            
            Alamofire.request(method, "\(baseURL)\(api)", parameters: parameters)
                .responseJSON { response in
                    completionHandler(response)
            }
            
            if let parameters = parameters {
                dprint("\(method) \(baseURL)\(api) \(parameters)")
            }
            else {
                dprint("\(method) \(baseURL)\(api)")
            }
        }
        
        operationQueue.addOperation(blockOperation)
    }
}
