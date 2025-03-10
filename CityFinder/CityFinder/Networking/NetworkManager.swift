//
//  NetworkManager.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 09/03/2025.
//

import Foundation

class NetworkManager {
    func fetchCities() async throws -> [CityModel] {
        guard let url = URL(string: URLs.citiesEndpoint) else {
            throw NetworkingError.invalidURL
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw NetworkingError.networkError(URLError(.badServerResponse))
            }
            
            return try JSONDecoder().decode([CityModel].self, from: data)
        } catch let error as URLError {
            throw NetworkingError.networkError(error)
        } catch let error as DecodingError {
            throw NetworkingError.decodingError(error)
        } catch {
            throw NetworkingError.unknownError
        }
    }
}
