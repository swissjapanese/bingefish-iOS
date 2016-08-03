//
//  BFHelper.swift
//  Bingefish
//
//  Created by Genki Mine on 7/27/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit

class BFHelper: NSObject
{
    class func isIPhoneOrIPod() -> Bool
    {
        return UIDevice.currentDevice().userInterfaceIdiom == .Phone
    }
    
    class func isIPad() -> Bool
    {
        return UIDevice.currentDevice().userInterfaceIdiom == .Pad
    }
    
    class func dispatchAfterInMainQueue(delay:Double, closure:()->())
    {
        dispatch_after (
            dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(), closure
        )
    }
    
    class func dispatchAfterInDefaultQueue(delay:Double, closure:()->())
    {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), closure
        )
    }
    
    class func topViewController() -> UIViewController?
    {
        if let window = UIApplication.sharedApplication().delegate?.window {
            if var topViewController = window!.rootViewController {
                while let presentedViewController = topViewController.presentedViewController {
                    topViewController = presentedViewController
                }
                return topViewController
            }
        }
        
        return nil
    }
    
    class func isValidEmail(testStr:String) -> Bool 
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
}

func dprint(string: String)
{
    #if DEBUG
        print("🐸BFDEBUG: \(string)")
    #endif
}
