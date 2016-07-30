//
//  BFShow+CoreData.swift
//  Bingefish
//
//  Created by Genki Mine on 7/30/16.
//  Copyright © 2016 Bingefish. All rights reserved.
//

import UIKit
import CoreData

extension BFShow
{
    @NSManaged var tvdbid: String?
    @NSManaged var seriesName: String?
    @NSManaged var overview: String?
    @NSManaged var fanartURLString: String?
}
