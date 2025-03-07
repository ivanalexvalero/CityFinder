//
//  HomeScreen.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel: CityViewModel

    init(viewModel: CityViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        LazyVStack {
            ForEach(viewModel.cities) { city in
                Text("Ciudad:\(city.name)")
            }
        }
    }
}
