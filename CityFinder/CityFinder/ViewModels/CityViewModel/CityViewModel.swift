//
//  CityViewModel.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation

import SwiftData

class CityViewModel: ObservableObject {
    @Published var cities: [CityModel] = []
    @Published var filteredCities: [CityModel] = []
    @Published var selectedCity: CityModel?
    @Published var favoriteCities: [CityModel] = []
    @Published var isLandscape: Bool = false
    @Published var filter: String = "" {
        didSet { filterCities() }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cityService: CityFinderServiceProtocol
    private var modelContext: ModelContext

    init(cityService: CityFinderServiceProtocol, modelContext: ModelContext) {
        self.cityService = cityService
        self.modelContext = modelContext
        Task { await loadCities() }
    }

    @MainActor
    func loadCities() async {
        self.isLoading = true
        do {
            let allCities = try await cityService.fetchCities()
            await MainActor.run {
                self.cities = allCities
                self.favoriteCities = cities.filter { $0.isFavorite }
                self.filterCities()
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.errorMessage = CityFinderErrorConstants.loadCitiesErrorMessage
            }
        }
    }

    private func filterCities() {
        filteredCities = cities.filter {
            $0.name.lowercased().hasPrefix(filter.lowercased())
        }.sorted { $0.name < $1.name }
    }

    @MainActor
    func toggleFavorite(for city: CityModel) {
        guard let index = cities.firstIndex(where: { $0.id == city.id }) else { return }

        cities[index].isFavorite.toggle()

        if cities[index].isFavorite {
            favoriteCities.append(cities[index])
        } else {
            favoriteCities.removeAll { $0.id == city.id }
        }

        do {
            try modelContext.save()
        } catch {
           error.localizedDescription
        }

        saveFavoritesToDatabase()
        filterCities()
    }

    func saveFavoritesToDatabase() {
        do {
            for city in favoriteCities { modelContext.insert(city) }
            try modelContext.save()
        } catch {
            error.localizedDescription
        }
    }
}
