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
