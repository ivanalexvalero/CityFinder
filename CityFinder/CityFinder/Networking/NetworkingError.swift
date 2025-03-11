//
//  NetworkingError.swift
//  CityFinder
//
//  Created by Ivan Alexander Valero on 06/03/2025.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case unknownError
}

extension NetworkingError {
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError:
            return "A network error occurred"
        case .decodingError:
            return "A decoding error occurred"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}
