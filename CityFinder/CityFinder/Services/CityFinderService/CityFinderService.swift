//
//  CityFinderService.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation
import SwiftData

@Observable
class CityFinderService: CityFinderServiceProtocol {
    private var cache: [CityModel]?
    private let databaseManager: DatabaseManager
    private let networkManager: NetworkManager
    
    init(databaseManager: DatabaseManager, networkManager: NetworkManager) {
        self.databaseManager = databaseManager
        self.networkManager = networkManager
    }
    
    func fetchCities() async throws -> [CityModel] {
        if let cache, !cache.isEmpty { return cache }

        let storedCities = try await databaseManager.fetchCities()
        if !storedCities.isEmpty {
            cache = storedCities
            return storedCities
        }
        
        let cities = try await networkManager.fetchCities()
        try await databaseManager.saveCities(cities)
        
        cache = cities
        return cities
    }
}
