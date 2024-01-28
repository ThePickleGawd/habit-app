//
//  GeofenceRegion.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import CoreLocation

struct GeofenceRegion : Codable {
    var center: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    
    init(center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String) {
        self.center = center
        self.radius = radius
        self.identifier = identifier
    }

    private enum CodingKeys: String, CodingKey {
        case centerLatitude = "center_lat"
        case centerLongitude = "center_lon"
        case radius
        case identifier
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let lat = try container.decode(Double.self, forKey: .centerLatitude)
        let lon = try container.decode(Double.self, forKey: .centerLongitude)
        center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        radius = try container.decode(CLLocationDistance.self, forKey: .radius)
        identifier = try container.decode(String.self, forKey: .identifier)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(center.latitude, forKey: .centerLatitude)
        try container.encode(center.longitude, forKey: .centerLongitude)
        try container.encode(radius, forKey: .radius)
        try container.encode(identifier, forKey: .identifier)
    }
}
