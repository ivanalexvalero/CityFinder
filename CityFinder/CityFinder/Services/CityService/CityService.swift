//
//  CityService.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation
import SwiftData


@Observable
class CityService {
    private var cache: [CityModel]?
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchCities() async throws -> [CityModel] {
        let descriptor = FetchDescriptor<CityModel>()

        // Asegurar que la consulta se hace en el hilo correcto
        let storedCities = try await MainActor.run {
            try? modelContext.fetch(descriptor)
        }

        if let storedCities, !storedCities.isEmpty {
            return storedCities
        }

        guard let url = URL(string: URLs.citiesEndpoint) else {
            throw CityGenericError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let cities = try JSONDecoder().decode([CityModel].self, from: data)

            // Guardar en la base de datos en el hilo principal
            try await MainActor.run {
                for city in cities {
                    modelContext.insert(city)
                }
                try modelContext.save()
            }

            return cities
        } catch let error as URLError {
            throw CityGenericError.networkError(error)
        } catch let error as DecodingError {
            throw CityGenericError.decodingError(error)
        } catch {
            throw CityGenericError.unknownError
        }
    }

}

