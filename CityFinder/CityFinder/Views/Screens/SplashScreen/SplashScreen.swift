//
//  SplashScreen.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 11/03/2025.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Image(systemName: "map.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.accentColor)
                .padding()

            Text(CityFinderConstants.appName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()

            ProgressView(CityFinderConstants.loadingSplashText)
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashScreen()
}

