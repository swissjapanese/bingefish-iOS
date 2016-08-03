//
//  BFSessionController.swift
//  Bingefish
//
//  Created by Genki Mine on 8/2/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFSessionController: NSObject 
{
    static let sharedController = BFSessionController()
    var appDelegate: AppDelegate!
    var previousBundleVersion: String!
    var currentBundleVersion: String!
    var sessionCount: Int!
    
    func setUp(appDelegate: AppDelegate)
    {
        self.appDelegate = appDelegate
        
        previousBundleVersion = NSUserDefaults.standardUserDefaults().stringForKey(BFUserDefaultsPreviousBundleVersionKey)
        currentBundleVersion = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String
        dprint("previousBundleVersion:\(previousBundleVersion) currentBundleVersion:\(currentBundleVersion)")
        
        if isOnDifferentVersion() {
            removePreviousCoreDataFile()
        }
        
        NSUserDefaults.standardUserDefaults().setObject(currentBundleVersion!, forKey: BFUserDefaultsPreviousBundleVersionKey)
        
        var sessionCount = NSUserDefaults.standardUserDefaults().integerForKey(BFUserDefaultsSessionCountKey)
        sessionCount = sessionCount + 1
        NSUserDefaults.standardUserDefaults().setInteger(sessionCount, forKey: BFUserDefaultsSessionCountKey)
        self.sessionCount = sessionCount
    }
    
    func removePreviousCoreDataFile()
    {
        if let path = appDelegate.coreDataFileURL?.path {
            if NSFileManager.defaultManager().fileExistsAtPath(path) {
                do {
                    try NSFileManager.defaultManager().removeItemAtURL(appDelegate.coreDataFileURL!)
                }
                catch let error as NSError {
                    dprint("Failed to remove URL \(error)")
                }
            }
        }
    }
    
    func isOnDifferentVersion() -> Bool
    {
        if let previousBundleVersion = previousBundleVersion {
            if previousBundleVersion != currentBundleVersion {
                return true
            }
        }
        return false
    }
}
