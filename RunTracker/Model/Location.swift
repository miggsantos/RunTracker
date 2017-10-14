//
//  Location.swift
//  RunTracker
//
//  Created by Miguel Santos on 14/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic public private(set) var latitude = 0.0
    @objc dynamic public private(set) var longintude = 0.0
    
    convenience init(latitude: Double, longintude: Double) {
        self.init()
        self.latitude = latitude
        self.longintude = longintude
    }
}
