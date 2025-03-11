//
//  OrientationManager.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 09/03/2025.
//

import SwiftUI

struct OrientationManager {
    @ObservedObject var cityViewModel: CityViewModel

    func handleOrientation<Content: View>(@ViewBuilder content: @escaping (Bool) -> Content) -> some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            content(isLandscape)
                .onAppear {
                    cityViewModel.updateOrientation(isLandscape: isLandscape)
                }
        }
    }
}
