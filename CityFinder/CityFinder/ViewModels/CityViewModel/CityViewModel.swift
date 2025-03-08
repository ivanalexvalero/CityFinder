//
//  CityViewModel.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation

class CityViewModel: ObservableObject {
    @Published var cities: [CityModel] = []
    @Published var filteredCities: [CityModel] = []
    @Published var selectedCity: CityModel?
    @Published var isLandscape: Bool = false
    @Published var filter: String = "" {
        didSet {
            filterCities()
        }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cityService: CityServiceProtocol

    init(cityService: CityServiceProtocol) {
        self.cityService = cityService
        Task {
            await loadCities()
        }
    }

@MainActor
    func loadCities() async {
        self.isLoading = true
        do {
            let allCities = try await cityService.fetchCities()
            // Actualiza la UI en el hilo principal
            await MainActor.run {
                self.cities = allCities
                self.filterCities()
                self.isLoading = false
            }
        } catch let error as CityGenericError {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = CityGenericError.errorDefaultMessage.errorMessage
            }
        }
    }

    private func filterCities() {
        filteredCities = cities.filter {
            $0.name.lowercased().hasPrefix(filter.lowercased())
        }.sorted { $0.name < $1.name }
    }
}
