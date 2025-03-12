//
//  CityListContentView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 12/03/2025.
//

import SwiftUI
import SwiftData

struct CityListContentView: View {
    @ObservedObject var cityViewModel: CityViewModel
    @Binding var showingFavorites: Bool
    @Environment(\.colorScheme) var colorScheme

    var displayedCities: [CityModel] {
        let filteredList = cityViewModel.filter.isEmpty ? cityViewModel.cities : cityViewModel.filteredCities
        let favoritesFilteredList = showingFavorites ? filteredList.filter { $0.isFavorite } : filteredList
        return Array(favoritesFilteredList.prefix(cityViewModel.currentPage * cityViewModel.pageSize))
    }

    var body: some View {
        List(displayedCities) { city in
            CityRowView(
                city: city,
                toggleFavorite: { [weak cityViewModel] in
                    cityViewModel?.toggleFavorite(for: city)
                },
                selectCity: { [weak cityViewModel] in
                    cityViewModel?.selectedCity = city }
            )
            .accessibilityIdentifier("City_\(city.name)_Row")
            .onAppear { checkIfShouldLoadMore(city: city) }
        }
        .searchable(text: $cityViewModel.filter, prompt: CityFinderConstants.promptSearch)
        .navigationTitle(CityFinderConstants.cities)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarBackground(colorScheme == .dark ? Color.black : Color.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation(.bouncy) {
                        showingFavorites.toggle()
                    }
                }) {
                    Image(systemName: showingFavorites ? CityFinderIconConstants.heartFill : CityFinderIconConstants.heart)
                        .foregroundColor(showingFavorites ? .red : .gray)
                }
                .accessibilityIdentifier("ShowFavoritesButton")
            }
        }
        .onAppear {
            Task {
                Task {
                    if cityViewModel.cities.isEmpty {
                        await cityViewModel.loadCities()
                    } else if displayedCities.isEmpty {
                        cityViewModel.loadNextPage()
                    }
                }
            }
        }
    }

    private func checkIfShouldLoadMore(city: CityModel) {
        guard !cityViewModel.isLoading, city.id == displayedCities.last?.id else { return }
        Task {  [weak cityViewModel] in
            cityViewModel?.loadNextPage()
        }
    }
}

