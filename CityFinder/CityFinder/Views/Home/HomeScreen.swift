//
//  HomeScreen.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var cityViewModel: CityViewModel

    var body: some View {
        Group {
            CityListView(cityViewModel: cityViewModel)
        }
    }
}

#Preview {
    HomeScreen(cityViewModel: CityViewModel(cityService: CityServiceMock()))
}
