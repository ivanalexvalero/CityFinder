//
//  HomeScreen.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var cityViewModel: CityViewModel
    private let orientationManager: OrientationManager

    init(cityViewModel: CityViewModel) {
        self.cityViewModel = cityViewModel
        self.orientationManager = OrientationManager(cityViewModel: cityViewModel)
    }

    var body: some View {
        orientationManager.handleOrientation { isLandscape in
            Group {
                if isLandscape {
                    // Landscape
                    HStack {
                        VStack {
                            CityListView(cityViewModel: cityViewModel)
                                .frame(width: UIScreen.main.bounds.width * 0.34)
                                .padding(.horizontal, 2)
                        }
                        if let selectedCity = cityViewModel.selectedCity {
                            CityMapView(city: selectedCity)
                                .frame(width: UIScreen.main.bounds.width * 0.5)
                        } else {
                            CityFinderText(text: CityFinderConstants.emptyMapText)
                                .frame(width: UIScreen.main.bounds.width * 0.5)
                        }
                    }
                } else {
                    // Portrait
                    CityListView(cityViewModel: cityViewModel)
                        .sheet(item: $cityViewModel.selectedCity) { city in
                            CityMapView(city: city)
                        }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}


