//
//  CityInfoRowCardView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 11/03/2025.
//

import SwiftUI

struct CityInfoRowCardView: View {
    let icon: String
    let text: String
    let accessibilityId: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            CityFinderText(text: text, font: CityFinderFonts.robotoRegular20)
                .foregroundColor(.black)
        }
        .accessibilityIdentifier(accessibilityId)
    }
}

#Preview {
    CityInfoRowCardView(icon: "location.fill",
                        text: "lat: 38.716671",
                        accessibilityId: "cityLatitudeText")
}
