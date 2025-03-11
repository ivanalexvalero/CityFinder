//
//  CityRowView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 09/03/2025.
//

import SwiftUI

struct CityRowView: View {
    let city: CityModel
    let toggleFavorite: () -> Void
    let selectCity: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                CityFinderText(text: "\(city.name), \(city.country)", font: CityFinderFonts.robotoRegular20)
                    .accessibilityIdentifier("CityRow_\(city.name)_Name")
                Divider()
                    .padding(.trailing, 8)
                HStack {
                    CityFinderText(text: CityFinderConstants.longitude.replacingOccurrences(of: Constants.placeholder, with: "\(city.lon)"), font: CityFinderFonts.robotoRegular14)
                        .accessibilityIdentifier("CityRow_\(city.name)_Longitude")
                    CityFinderText(text: CityFinderConstants.latitude.replacingOccurrences(of: Constants.placeholder, with: "\(city.lat)"), font: CityFinderFonts.robotoRegular14)
                        .accessibilityIdentifier("CityRow_\(city.name)_Latitude")
                }
            }
            .tint(.black)

            Spacer()

            Button(action: {
                withAnimation(.spring()) {
                    toggleFavorite()
                }
            }) {
                Image(systemName: city.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(city.isFavorite ? .red : .gray)
            }
            .accessibilityIdentifier("CityRow_\(city.name)_HeartButton")
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing)
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            selectCity()
        }
        .allowsHitTesting(true)
        .accessibilityIdentifier("CityRow_\(city.name)_Row")
    }
}


#Preview {
    CityRowView(city: CityModel.cities) {} selectCity: {}
}

