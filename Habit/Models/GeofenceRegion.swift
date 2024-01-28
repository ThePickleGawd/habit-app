//
//  GeofenceRegion.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import CoreLocation

struct GeofenceRegion {
    var center: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String

    init(center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String) {
        self.center = center
        self.radius = radius
        self.identifier = identifier
    }

    // You can add additional properties or methods if required
}
