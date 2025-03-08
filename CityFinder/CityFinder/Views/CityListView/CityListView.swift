//
//  CityListView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 08/03/2025.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var cityViewModel: CityViewModel
    @State private var showAlert = false

    init(cityViewModel: CityViewModel) {
        self.cityViewModel = cityViewModel
    }

    var body: some View {
        NavigationView {
            ScrollView {
                if cityViewModel.isLoading {
                    ProgressView(CityFinderConstants.loadingProgress)
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        // Made use of LazyVStack: more efficient in terms of memory usage and rendering times
                        ForEach(cityViewModel.filteredCities) { city in
                            Button(action: {
                                cityViewModel.selectedCity = city
                            }) {
                                VStack(alignment: .leading) {
                                    CityFinderText(text: "\(city.name), \(city.country)")
                                        .font(.headline)
                                    CityFinderText(text: "\(CityFinderConstants.longitude.replacingOccurrences(of: Constants.placeholder, with: "\(city.lon)")), \(CityFinderConstants.latitude.replacingOccurrences(of: Constants.placeholder, with: "\(city.lat)"))")
                                        .font(.subheadline)
                                }
                            }
                            .accessibilityIdentifier("city-row-\(city.name)")
                        }
                    }
                    .padding(.leading, 20)
                    .tint(.black)
                }
            }
            .searchable(text: $cityViewModel.filter, prompt: CityFinderConstants.promptSearch)
            .navigationTitle(CityFinderConstants.cities)
            .toolbarBackground(.white, for: .navigationBar)
            .onChange(of: cityViewModel.errorMessage) {
                self.showAlert = cityViewModel.errorMessage != nil
            }
        }
        .onAppear {
            Task {
                await cityViewModel.loadCities()
            }
        }
    }
}

#Preview {
    CityListView(cityViewModel: CityViewModel(cityService: CityServiceMock()))
}
