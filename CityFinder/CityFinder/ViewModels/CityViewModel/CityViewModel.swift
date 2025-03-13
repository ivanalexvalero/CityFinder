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
    @Published var displayedCities: [CityModel] = []
    @Published var selectedCity: CityModel?
    @Published var favoriteCities: [CityModel] = []
    @Published var isLandscape: Bool = false
    @Published var filter: String = "" {
        didSet { filterCities() }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let cityService: CityFinderServiceProtocol
    private let modelContext: ModelContext
    var pageSize = 20
    var currentPage = 0

    init(cityService: CityFinderServiceProtocol, modelContext: ModelContext) {
        self.cityService = cityService
        self.modelContext = modelContext
        Task { [weak self] in
            await self?.loadCities()
        }
    }

    @MainActor
    func loadCities() async {
        self.isLoading = true
        do {
            let allCities = try await cityService.fetchCities()
            await MainActor.run { [weak self] in
                guard let self = self else { return }
                self.cities = allCities
                self.favoriteCities = self.cities.filter { $0.isFavorite }
                self.filterCities()
//                self.loadNextPage()
                self.isLoading = false
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.isLoading = false
                self?.errorMessage = CityFinderErrorConstants.loadCitiesErrorMessage
            }
        }
    }

    private func filterCities() {
        if filter.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter {
                $0.name.lowercased().hasPrefix(filter.lowercased())
            }.sorted { $0.name < $1.name }
        }
        resetPagination()
    }

    func resetPagination() {
        currentPage = 0
        displayedCities = []
        loadNextPage()
    }

    
    func loadNextPage() {
        guard !isLoading else { return }
        let nextPage = filteredCities.dropFirst(currentPage * pageSize).prefix(pageSize)
        if !nextPage.isEmpty {
            displayedCities.append(contentsOf: nextPage)
            currentPage += 1
        }
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

    func updateOrientation(isLandscape: Bool) {
        self.isLandscape = isLandscape
    }
}
