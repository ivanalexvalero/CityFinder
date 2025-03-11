//
//  CityFinderFonts.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 10/03/2025.
//

import SwiftUI

struct CityFinderFonts {
    static func customFont(name: String, size: CGFloat, weight: Font.Weight) -> Font {
        if let customFont = UIFont(name: name, size: size) {
            return Font(customFont).weight(weight)
        } else {
            return Font.system(size: size, weight: weight)
        }
    }
    
    static let robotoRegular14 = customFont(name: "Roboto-Regular", size: 14, weight: .regular)
    static let robotoRegular20 = customFont(name: "Roboto-Regular", size: 20, weight: .regular)
    static let robotoRegular30 = customFont(name: "Roboto-Regular", size: 30, weight: .regular)
    static let robotoBold100 = customFont(name: "Roboto-Bold", size: 100, weight: .bold)
}
