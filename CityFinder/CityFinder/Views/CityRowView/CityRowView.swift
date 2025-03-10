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
            VStack(alignment: .leading) {
                CityFinderText(text: "\(city.name), \(city.country)")
                    .font(.headline)
                CityFinderText(text: "\(CityFinderConstants.longitude.replacingOccurrences(of: Constants.placeholder, with: "\(city.lon)")), \(CityFinderConstants.latitude.replacingOccurrences(of: Constants.placeholder, with: "\(city.lat)"))")
                    .font(.subheadline)
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
            .buttonStyle(PlainButtonStyle())
        }
        .onTapGesture {
            selectCity()
        }
        .padding(.horizontal)
    }
}

#Preview {
    CityRowView(city: CityModel.cities) { } selectCity: { }
}
