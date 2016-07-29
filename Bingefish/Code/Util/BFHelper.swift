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
}

func dprint(string: String)
{
    #if DEBUG
        print(string)
    #endif
}

func dispatchAfterInMainQueue(delay:Double, closure:()->())
{
    dispatch_after (
        dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
        dispatch_get_main_queue(), closure
    )
}

func dispatchAfterInDefaultQueue(delay:Double, closure:()->())
{
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), closure
    )
}
