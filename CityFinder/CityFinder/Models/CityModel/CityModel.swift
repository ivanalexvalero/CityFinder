//
//  CityModel.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation
import SwiftData

@Model
final class CityModel: Codable, Identifiable, Equatable {
    var country: String
    var name: String
    @Attribute(.unique) var id: Int
    var lon: Double
    var lat: Double

    init(country: String, name: String, id: Int, lon: Double, lat: Double) {
        self.country = country
        self.name = name
        self.id = id
        self.lon = lon
        self.lat = lat
    }

    private enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }

    struct Coordinates: Codable, Equatable {
        let lon: Double
        let lat: Double
    }

    // Implementación de Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.country = try container.decode(String.self, forKey: .country)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)

        let coordinates = try container.decode(Coordinates.self, forKey: .coord)
        self.lon = coordinates.lon
        self.lat = coordinates.lat
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(country, forKey: .country)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(Coordinates(lon: lon, lat: lat), forKey: .coord)
    }

    // Implementación del protocolo Equatable
    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.country == rhs.country &&
               lhs.name == rhs.name &&
               lhs.id == rhs.id &&
               lhs.lon == rhs.lon &&
               lhs.lat == rhs.lat
    }
}
