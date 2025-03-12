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
            if cityViewModel.isLoading {
                ProgressView(CityFinderConstants.loadingProgress)
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                CityListContentView(cityViewModel: cityViewModel,
                                    showingFavorites: $showingFavorites)
            }
        }
        .accessibilityIdentifier("CityListView")
    }
}

