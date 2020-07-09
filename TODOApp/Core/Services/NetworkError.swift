//
//  NetworkError.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case dataNotExtracted
    case notFound
    case unauthorized
    case otherError

    static func error(fromStatusCode statusCode: Int) -> NetworkError {
        switch statusCode {
        case 401:
            return .unauthorized
        case 404:
            return .notFound
        default:
            return .otherError
        }
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch(lhs, rhs) {
        case (.dataNotExtracted, .dataNotExtracted): return true
        case (.notFound, .notFound): return true
        case (.unauthorized, .unauthorized): return true
        case (.otherError, .otherError): return true

        default: return false
        }
    }
}
