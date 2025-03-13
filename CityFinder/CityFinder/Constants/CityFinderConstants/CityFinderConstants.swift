//
//  CityFinderConstants.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 08/03/2025.
//

import Foundation

struct CityFinderConstants {
    static let lon = "Lon: "
    static let lat = "Lat: "
    static let longitude = "\(lon)<PLACEHOLDER>"
    static let latitude = "\(lat)<PLACEHOLDER>"
    static let cities = "Ciudades"
    static let promptSearch = "Buscar ciudades..."
    static let loadingProgress = "Cargando ciudades..."
    static let moreInfoAbout = "Mas info sobre"
    static let emptyMapText = "Selecciona una ciudad para ver en el mapa"
    static let citiesDetails = "Detalles de la Ciudad"
    static let loadingSplashText = "Cargando..."
    static let appName = "City Finder"
}

struct CityFinderIconConstants {
    static let closeViewIcon = "xmark.circle.fill"
    static let mapViewIcon = "map.fill"
    static let lonIcon = "mappin.and.ellipse"
    static let latIcon = "location.fill"
    static let heartFill = "heart.fill"
    static let heart = "heart"
}

struct Constants {
    static let placeholder = "<PLACEHOLDER>"
}

struct CityFinderErrorConstants {
    static let loadCitiesErrorMessage = "Error al cargar las ciudades"
}
