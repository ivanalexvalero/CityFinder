//
//  CityFinderText.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 08/03/2025.
//

import SwiftUI

struct CityFinderText: View {
    var text: String
    var font: Font

    var body: some View {
        Text(text)
            .font(font)
    }
}
