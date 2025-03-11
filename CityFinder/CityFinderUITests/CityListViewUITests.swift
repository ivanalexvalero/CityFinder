//
//  CityListViewUITests.swift
//  CityFinderUITests
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//


import XCTest

final class CityListViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testCityListViewDisplaysCities() throws {
        let app = XCUIApplication()
        app.launch()

        let cityListView = app.otherElements["CityListView"]
        debugPrint(app.debugDescription)
        XCTAssertTrue(cityListView.exists, "La vista de lista de ciudades debería existir.")

        let firstCity = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCity.waitForExistence(timeout: 5), "Debería haber al menos una ciudad en la lista.")
    }

    @MainActor
    func testToggleFavorites() throws {
        let app = XCUIApplication()
        app.launch()

        let favoritesButton = app.buttons["ShowFavoritesButton"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5), "❌ El botón de favoritos no apareció.")

        let cityCell = app.cells.containing(.staticText, identifier: "City_Helsinki_Row").firstMatch
        XCTAssertTrue(cityCell.waitForExistence(timeout: 5), "❌ No se encontró la celda de la ciudad Helsinki.")

        let favoriteButton = cityCell.buttons.firstMatch
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5), "❌ No se encontró el botón de marcar como favorito.")

        favoriteButton.tap()

        favoritesButton.tap()

        let favoriteCityCell = app.cells.containing(.staticText, identifier: "City_Helsinki_Row").firstMatch
        XCTAssertTrue(favoriteCityCell.waitForExistence(timeout: 5), "❌ No se encontró la ciudad en la lista de favoritos.")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
