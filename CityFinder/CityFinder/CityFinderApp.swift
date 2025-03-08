//
//  CityFinderApp.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import SwiftUI
import SwiftData

@main
struct CityFinderApp: App {
    @StateObject private var cityViewModel: CityViewModel
    let modelContainer: ModelContainer

    init() {
        // Configurar SwiftData
        let schema = Schema([CityModel.self])
        modelContainer = try! ModelContainer(for: schema)
        let modelContext = modelContainer.mainContext

        // Configurar servicio
        #if DEBUG
        // Uso de Mock para previews
        let cityService: CityServiceProtocol = CityServiceMock()
        #else
        // Uso de servicio
        let cityService: CityServiceProtocol = CityService(modelContext: modelContext)
        #endif
        _cityViewModel = StateObject(wrappedValue: CityViewModel(cityService: cityService))
    }

    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: cityViewModel)
                .modelContainer(modelContainer)
        }
    }
}
