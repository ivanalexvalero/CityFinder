//
//  CityViewModel.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation

class CityViewModel: ObservableObject {
    @Published var cities: [CityModel] = []
    private var cityService: CityServiceProtocol

    init(cityService: CityServiceProtocol) {
        self.cityService = cityService
        Task {
            await self.loadCities()
        }
    }

    func loadCities() async {
        do {
            let cities = try await cityService.fetchCities()

            await MainActor.run {
                self.cities = cities
            }
        } catch let error as CityGenericError {
                self.errorMessage = error.localizedDescription
        } catch {
            await MainActor.run {
                self.errorMessage = CityGenericError.errorDefaultMessage.errorMessage
            }
        }
    }
}
