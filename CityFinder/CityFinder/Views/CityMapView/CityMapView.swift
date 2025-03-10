//
//  CityMapView.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 09/03/2025.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    var city: CityModel

    @State private var region: MKCoordinateRegion
    @State private var showInfoSheet = false

    init(city: CityModel) {
        self.city = city
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        GeometryReader { geometry in
            // calculo con geometry para dividir la pantalla
            ZStack {
                    Map(coordinateRegion: $region)
                        .navigationTitle("\(city.name), \(city.country)")
                        .navigationBarTitleDisplayMode(.inline)
                        .padding(.top, 25)
                        .onChange(of: city) { newCity in
                            updateRegion(for: newCity)
                        }
                        .presentationCornerRadius(30.0)
                VStack {
                    if geometry.size.width < geometry.size.height {
                        Capsule()
                            .frame(width: 60, height: 5)
                            .foregroundColor(.black.opacity(0.3))
                            .padding(.top, 8)
                    }
                    Spacer()
                    Button {
                        showInfoSheet.toggle()
                    } label: {
                        CityFinderText(text: "\(CityFinderConstants.moreInfoAbout) \(city.name)")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
        }
    }

    private func updateRegion(for city: CityModel) {
        region.center = CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon)
    }
}

#Preview {
    CityMapView(city: CityModel.cities)
}
