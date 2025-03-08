//
//  HomeScreen.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var cityViewModel: CityViewModel

    init(viewModel: CityViewModel) {
        self.cityViewModel = viewModel
    }

    var body: some View {
        VStack {
            if cityViewModel.cities.isEmpty {
                Text("Loading...")
            } else {
                List(cityViewModel.cities) { city in
                    Text(city.name)
                }
            }
        }
        .task {
            await cityViewModel.loadCities()
        }
    }
}
#Preview {
    HomeScreen(viewModel: CityViewModel(cityService: CityServiceMock()))
}
