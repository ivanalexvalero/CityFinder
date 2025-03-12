//
//  CityCardView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 11/03/2025.
//

import SwiftUI

struct CityCardView: View {
    let cityModel: CityModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            CityFinderText(text: cityModel.country,
                           font: CityFinderFonts.robotoBold100)
            .foregroundColor(.indigo)
            .accessibilityIdentifier("cityCountryText")
            
            CityFinderText(text: "\(cityModel.name), \(cityModel.country)",
                           font: CityFinderFonts.robotoRegular30)
            .accessibilityIdentifier("cityNameText")
            .foregroundColor(.black)
            
            Divider()
                .padding(.horizontal, 40)
            
            CityInfoRowCardView(icon: CityFinderIconConstants.lonIcon,
                                text: "\(CityFinderConstants.longitude.replacingOccurrences(of: Constants.placeholder, with: " \(cityModel.lon)"))",
                                accessibilityId: "cityLongitudeText")
            
            CityInfoRowCardView(icon: CityFinderIconConstants.latIcon,
                                text: "\(CityFinderConstants.longitude.replacingOccurrences(of: Constants.placeholder, with: " \(cityModel.lat)"))",
                                accessibilityId: "cityLatitudeText")
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}

#Preview {
    CityCardView(cityModel: CityModel.cities)
}

