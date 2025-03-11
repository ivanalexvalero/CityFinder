//
//  CityListView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 08/03/2025.
//

import SwiftUI
import SwiftData

struct CityListView: View {
    @ObservedObject var cityViewModel: CityViewModel
    @State private var showingFavorites = false

    init(cityViewModel: CityViewModel) {
        self.cityViewModel = cityViewModel
    }

    var body: some View {
        NavigationStack {
            List(showingFavorites ? cityViewModel.filteredCities.filter { $0.isFavorite } : cityViewModel.filteredCities) { city in
                CityRowView(
                    city: city,
                    toggleFavorite: { cityViewModel.toggleFavorite(for: city) },
                    selectCity: { cityViewModel.selectedCity = city }
                )
                .accessibilityIdentifier("City_\(city.name)_Row") // Identificador para cada fila de ciudad
            }
            .searchable(text: $cityViewModel.filter, prompt: CityFinderConstants.promptSearch)
            .navigationTitle(CityFinderConstants.cities)
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(.bouncy) {
                            showingFavorites.toggle()
                        }
                    }) {
                        Image(systemName: showingFavorites ? "heart.fill" : "heart")
                            .foregroundColor(showingFavorites ? .red : .gray)
                    }
                    .accessibilityIdentifier("ShowFavoritesButton") // Identificador del botón de mostrar favoritos
                }
            }
            .onAppear {
                if cityViewModel.cities.isEmpty && !cityViewModel.isLoading {
                    Task {
                        await cityViewModel.loadCities()
                    }
                }
            }
        }
        .accessibilityIdentifier("CityListView")
    }
}

