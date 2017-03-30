//
//  Location.swift
//  MobileTest(SeowYungHoe)
//
//  Created by Seow Yung Hoe on 29/03/2017.
//  Copyright © 2017 Seow Yung Hoe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Location {
    
    var area : String?
    var city : String?
    
    init(json: JSON) {
        
        area = json["area"].stringValue
        city = json["city"].stringValue
    }
    
}
