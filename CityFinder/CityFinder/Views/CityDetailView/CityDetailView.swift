//
//  CityDetailView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 10/03/2025.
//

import SwiftUI

struct CityDetailView: View {
    let city: CityModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack (alignment: .center) {
                CityFinderText(text: city.country, font: CityFinderFonts.robotoBold100)
                    .foregroundColor(.indigo)
                    .accessibilityIdentifier("cityCountryText")

                CityFinderText(text: "\(city.name), \(city.country)", font: CityFinderFonts.robotoRegular30)
                    .accessibilityIdentifier("cityNameText")

                CityFinderText(text: "\(CityFinderConstants.longitude.replacingOccurrences(of: Constants.placeholder, with: " \(city.lon)"))", font: CityFinderFonts.robotoRegular20)
                    .accessibilityIdentifier("cityLongitudeText")

                CityFinderText(text: "\(CityFinderConstants.latitude.replacingOccurrences(of: Constants.placeholder, with: " \(city.lat)"))", font: CityFinderFonts.robotoRegular20)
                    .accessibilityIdentifier("cityLatitudeText")
            }
            .padding()
            .navigationTitle(CityFinderConstants.citiesDetails)
            .navigationBarTitleDisplayMode(.inline)
            .font(.title3)
            .frame(height: 300)
            .accessibilityIdentifier("CityDetailView_\(city.name)")
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
    CityDetailView(city: CityModel.cities)
}
