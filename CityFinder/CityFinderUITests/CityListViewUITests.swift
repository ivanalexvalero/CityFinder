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
        debugPrint("Yane",app.debugDescription)
        XCTAssertTrue(cityListView.exists, "La vista de lista de ciudades debería existir.")

        let firstCity = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCity.waitForExistence(timeout: 5), "Debería haber al menos una ciudad en la lista.")
    }

    @MainActor
    func testToggleFavorites() throws {
        let app = XCUIApplication()
        app.launch()

        let favoritesButton = app.buttons["ShowFavoritesButton"]
        XCTAssertTrue(favoritesButton.exists, "El botón de favoritos debería existir.")

        let firstCity = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCity.waitForExistence(timeout: 3), "Debería haber al menos una ciudad en la lista.")

        firstCity.tap()
        let favoriteButton = app.buttons.element(boundBy: 0)

        XCTAssertTrue(favoriteButton.exists, "El botón de marcar como favorito debería existir.")
        favoriteButton.tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        favoritesButton.forceTapElementFavorite()

        let firstFavorite = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstFavorite.waitForExistence(timeout: 3), "Debería haber al menos una ciudad en la lista de favoritos después de marcarla.")
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

extension XCUIElement {
    func forceTapElementFavorite() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            coordinate.tap()
        }
    }
}








//detail View

//import XCTest
//
//final class CityFinderUITests: XCTestCase {
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//    }
//
//    override func tearDownWithError() throws {
//        // Cleanup if needed
//    }
//
//    @MainActor
//    func testCityDetailViewDisplaysCorrectly() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        // Buscar el primer botón de ciudad en la lista
//        let firstCity = app.buttons["City_Lichtenrade"] // Usa el nombre como identificador
//        XCTAssertTrue(firstCity.exists, "El botón de la primera ciudad no existe")
//        firstCity.tap()
//
//        let moreInfoButton = app.buttons["MoreInfoButton_Lichtenrade"] // Ajusta el nombre si es necesario
//        XCTAssertTrue(moreInfoButton.exists, "El botón de más información no existe")
//        moreInfoButton.tap()
//
//        let detailView = app.otherElements["CityDetailView_Lichtenrade"] // Ajusta el nombre si es necesario
//        XCTAssertTrue(detailView.waitForExistence(timeout: 2), "No se muestra CityDetailView")
//
//        // Verificar textos de la ciudad
//        XCTAssertEqual(app.staticTexts["cityCountryText"].label, "DE", "El país no coincide")
//        XCTAssertEqual(app.staticTexts["cityNameText"].label, "Lichtenrade, DE", "El nombre de la ciudad no coincide")
//        XCTAssertEqual(app.staticTexts["cityLongitudeText"].label, "Longitude: 13.40637", "La longitud no coincide")
//        XCTAssertEqual(app.staticTexts["cityLatitudeText"].label, "Latitude: 52.398441", "La latitud no coincide")
//
//        // Verificar que el botón de cerrar existe y funciona
//        let closeButton = app.buttons["closeButton"]
//        XCTAssertTrue(closeButton.exists, "El botón de cerrar no existe")
//        closeButton.tap()
//
//        // Verificar que la vista de detalles desapareció
//        XCTAssertFalse(detailView.exists, "CityDetailView no se cerró correctamente")
//    }
//
//
//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
//}
//
