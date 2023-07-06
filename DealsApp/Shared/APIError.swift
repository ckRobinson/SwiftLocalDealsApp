//
//  APIError.swift
//  DealsApp
//
//  Created by Renu Punjabi on 7/3/23.
//

import Foundation

enum APIError: Error {
    case invalidUrl, decodingError
    
    var description: String {
        switch self {
            case .invalidUrl:
                return "Invalid url"
            case .decodingError:
                return "Decoding error"
        }
    }
}
