//
//  CityDetailScreen.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 10/03/2025.
//

import SwiftUI

struct CityDetailScreen: View {
    let cityModel: CityModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                CityCardView(cityModel: cityModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationTitle(CityFinderConstants.citiesDetails)
            .navigationBarTitleDisplayMode(.inline)
            .font(.title3)
            .accessibilityIdentifier("CityDetailView_\(cityModel.name)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: CityFinderConstants.closeView)
                            .foregroundColor(.red)
                            .font(.title3)
                    }
                    .accessibilityIdentifier("closeButton")
                }
            }
        }
    }
}

#Preview {
    CityDetailScreen(cityModel: CityModel.cities)
}
