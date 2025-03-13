//
//  CityFinderServiceProtocol.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 09/03/2025.
//

import Foundation

protocol CityFinderServiceProtocol {
    func fetchCities() async throws -> [CityModel]
}
