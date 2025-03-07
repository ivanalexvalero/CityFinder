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

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CityModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        // Inicializar CityService con el contexto de datos
        let cityService = CityService(modelContext: sharedModelContainer.mainContext)

        // Crear el ViewModel con el servicio inyectado
        _cityViewModel = StateObject(wrappedValue: CityViewModel(cityService: cityService))
    }

    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: cityViewModel)
                .modelContainer(sharedModelContainer)
        }
    }
}
