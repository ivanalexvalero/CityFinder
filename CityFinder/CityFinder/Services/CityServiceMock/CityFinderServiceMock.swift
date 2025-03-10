//
//  CityFinderServiceMock.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 08/03/2025.
//

import Foundation

class CityFinderServiceMock: CityFinderServiceProtocol {
    enum MockError: Error {
        case fileNotFound
        case decodingError
    }

    var shouldReturnError: Bool = false

    func fetchCities() async throws -> [CityModel] {
        if shouldReturnError { throw MockError.fileNotFound }

        guard let url = Bundle.main.url(forResource: CityFinderServiceMockConstants.resouce, withExtension: CityFinderServiceMockConstants.json) else {
            throw NSError(domain: CityFinderServiceMockConstants.domainNSError, code: 1, userInfo: [NSLocalizedDescriptionKey: CityFinderServiceMockConstants.userInfoNSLocalized])
        }

        let data = try Data(contentsOf: url)
        let cities = try JSONDecoder().decode([CityModel].self, from: data)
        return cities
    }
}
