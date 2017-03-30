//
//  Doctor.swift
//  MobileTest(SeowYungHoe)
//
//  Created by Seow Yung Hoe on 29/03/2017.
//  Copyright © 2017 Seow Yung Hoe. All rights reserved.
//

import Foundation
import SwiftyJSON

class Doctor {
    
    var id : Int?
    var name : String?
    var speciality : String?
    var area : String?
    var currency : String?
    var rate : Int!
    var photo : String?
    var recommendation : Int?
    var schedule: String
    var experience: Int?
    var latitude: Double?
    var longitute: Double?
    var description: String?
    
    
    
    
    
    init(json: JSON) {
        
        id = json["id"].intValue
        name = json["name"].stringValue
        speciality = json["speciality"].stringValue
        area = json["area"].stringValue
        currency = json["currency"].stringValue
        rate = json["rate"].intValue
        photo = json["photo"].stringValue
        
        
        recommendation = json["recommendation"].intValue
        schedule = json["schedule"].stringValue
        experience = json["experience"].intValue
        latitude = json["latitude"].doubleValue
        longitute = json["longitute"].doubleValue
        description = json["description"].stringValue


        
        

        
    }
    
}


