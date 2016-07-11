//
//  Country.swift
//  Test
//
//  Created by Vijay on 7/8/16.
//  Copyright © 2016 Vijay. All rights reserved.
//

import UIKit
import SQLite
import MapKit

// MARK: - Class -

class Country: NSObject {

    // MARK: - Properties -
    
    var countryId : Int64
    var code3L : String
    var code2L : String
    var name : String
    var officialName : String
    var flag32UrlString : String
    var flat128UrlString : String
    var latitude : CLLocationDegrees
    var longitude : CLLocationDegrees
    
    init(row : Array<Optional<Binding>>) {
        
        countryId = row[0] as! Int64
        code3L = row[1] as! String
        code2L = row[2] as! String
        name = row[3] as! String
        officialName = row[4] as! String
        flag32UrlString = row[5] as! String
        flat128UrlString = row[6] as! String
        latitude = CLLocationDegrees(row[7] as! String)!
        longitude = CLLocationDegrees(row[8] as! String)!

        super.init()
    }
    
}














