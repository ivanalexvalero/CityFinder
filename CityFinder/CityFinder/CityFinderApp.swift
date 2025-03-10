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
        guard let container = try? ModelContainer(for: schema) else {
            fatalError("No se pudo inicializar ModelContainer")
        }
        
        self.modelContainer = container
        let modelContext = modelContainer.mainContext
        let databaseManager = DatabaseManager(modelContext: modelContext)
        let networkManager = NetworkManager()

        // Configurar servicio
#if DEBUG
        // Uso de Mock para previews
        let cityService: CityFinderServiceProtocol = CityFinderServiceMock()
#else
        // Uso de servicio
        let cityService: CityFinderServiceProtocol = CityFinderService(databaseManager: databaseManager, networkManager: networkManager)

#endif
        _cityViewModel = StateObject(wrappedValue: CityViewModel(cityService: cityService, modelContext: modelContext))
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(cityViewModel: cityViewModel)
                .modelContainer(modelContainer)
        }
    }
}
