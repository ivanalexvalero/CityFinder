//
//  DatabaseManager.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 09/03/2025.
//

import Foundation
import SwiftData

class DatabaseManager {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchCities() async throws -> [CityModel] {
        return try await MainActor.run {
            let descriptor = FetchDescriptor<CityModel>()
            return try self.modelContext.fetch(descriptor)
        }
    }

    func saveCities(_ cities: [CityModel]) async throws {
        try await MainActor.run {
            for city in cities {
                modelContext.insert(city)
            }
            try modelContext.save()
        }
    }
}
