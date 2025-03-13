//
//  CityFinderServiceTests.swift
//  CityFinderTests
//
//  Created by Ivan Alexander Valero on 12/03/2025.
//

import Foundation
import Testing
@testable import CityFinder
import SwiftData

struct CityFinderServiceTests {

    private class MockDatabaseManager: DatabaseManager {
        var storedCities: [CityModel] = []
        var shouldThrowError = false
        let failureHandler: (String) -> NSError
        private let modelContext: ModelContext

        init(modelContext: ModelContext, failureHandler: @escaping (String) -> NSError) {
            self.modelContext = modelContext
            self.failureHandler = failureHandler
            super.init(modelContext: modelContext)
        }

        override func fetchCities() async throws -> [CityModel] {
            if shouldThrowError { throw failureHandler("Error en base de datos") }
            return storedCities
        }

        override func saveCities(_ cities: [CityModel]) async throws {
            storedCities = cities
        }
    }

    private class MockNetworkManager: NetworkManager {
        var responseCities: [CityModel] = []
        var shouldThrowError = false

        override func fetchCities() async throws -> [CityModel] {
            if shouldThrowError { throw NSError(domain: "TestError", code: 1, userInfo: nil) }
            return responseCities
        }
    }

    @Test
    func testFetchCities_FromDatabase() async throws {
        let container = try! ModelContainer(for: CityModel.self)
        let modelContext = ModelContext(container)

        let mockDatabase = MockDatabaseManager(modelContext: modelContext, failureHandler: testFailure(_:))
        let mockNetwork = MockNetworkManager()
        let service = CityFinderService(databaseManager: mockDatabase, networkManager: mockNetwork)

        mockDatabase.storedCities = [CityModel(country: "Francia", name: "Paris", id: 1, lon: 2.0, lat: 3.0)]

        let cities = try await service.fetchCities()

        #expect(cities.count == 1, "Debería devolver las ciudades almacenadas en la base de datos")
        #expect(cities.first?.name == "Paris", "La primera ciudad debería ser Paris")
    }

    @Test
    func testFetchCities_FromNetwork() async throws {
        let container = try! ModelContainer(for: CityModel.self)
        let modelContext = ModelContext(container)

        let mockDatabase = MockDatabaseManager(modelContext: modelContext, failureHandler: testFailure(_:))
        let mockNetwork = MockNetworkManager()
        let service = CityFinderService(databaseManager: mockDatabase, networkManager: mockNetwork)

        mockNetwork.responseCities = [CityModel(country: "Inglaterra", name: "Londres", id: 2, lon: 12.0, lat: 23.0)]

        let cities = try await service.fetchCities()

        #expect(cities.count == 1, "Debería devolver las ciudades obtenidas de la red")
        #expect(cities.first?.name == "Londres", "La primera ciudad debería ser Londres")
    }

    private func testFailure(_ message: String) -> NSError {
        return NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
