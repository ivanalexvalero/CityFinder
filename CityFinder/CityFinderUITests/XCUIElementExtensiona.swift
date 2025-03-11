//
//  XCUIElementExtensiona.swift
//  CityFinderUITests
//
//  Created by Ivan Alexander Valero on 11/03/2025.
//

import XCTest

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
