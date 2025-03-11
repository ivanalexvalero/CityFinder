//
//  CityMapScreenUITests.swift
//  CityFinderUITests
//
//  Created by Ivan Alexander Valero on 10/03/2025.
//

import XCTest

final class CityMapScreenUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testCityMapScreenExists() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.otherElements["CityListView"].waitForExistence(timeout: 5), "❌ La vista de la lista de ciudades no apareció.")

        let firstCityCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCityCell.waitForExistence(timeout: 5), "❌ No se encontró la celda de la ciudad.")

        firstCityCell.tap()
        sleep(2)

        let mapView = app.maps.firstMatch
        XCTAssertTrue(mapView.waitForExistence(timeout: 10), "❌ La vista del mapa nunca apareció en la UI.")

        XCTAssertTrue(mapView.isHittable, "❌ La vista del mapa está en la UI pero no es accesible.")
    }

    @MainActor
    func testMoreInfoButtonOpensDetailScreen() throws {
        let app = XCUIApplication()
        app.launch()

        let cityListView = app.otherElements["CityListView"]
        XCTAssertTrue(cityListView.waitForExistence(timeout: 5), "❌ La vista de la lista de ciudades no apareció.")

        let helsinkiCell = app.cells.containing(.staticText, identifier: "City_Helsinki_Row").firstMatch
        XCTAssertTrue(helsinkiCell.waitForExistence(timeout: 5), "❌ No se encontró la celda de la ciudad Helsinki.")

        helsinkiCell.tap()
        sleep(2)

        let cityMapView = app.otherElements["CityMapView_Helsinki"]
        XCTAssertTrue(cityMapView.waitForExistence(timeout: 10), "❌ La vista del mapa nunca apareció en la UI.")

           let moreInfoButton = app.buttons["MoreInfoButton_Helsinki"]

           let expectation = XCTNSPredicateExpectation(
               predicate: NSPredicate(format: "exists == true"),
               object: moreInfoButton
           )
           let result = XCTWaiter().wait(for: [expectation], timeout: 5)
           XCTAssertEqual(result, .completed, "❌ El botón de 'Más información' nunca apareció en la UI.")

           moreInfoButton.tap()

           let cityDetailView = app.otherElements["CityDetailView_Helsinki"]
           XCTAssertTrue(cityDetailView.waitForExistence(timeout: 5), "❌ La vista de detalles no se abrió.")
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
