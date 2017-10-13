//
//  Extensions.swift
//  RunTracker
//
//  Created by Miguel Santos on 13/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation

extension Double {
    
    func metersToMiles(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
    
    func metersRounded(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
