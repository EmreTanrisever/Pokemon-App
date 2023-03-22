//
//  NetworkEnum.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 22.03.2023.
//

import Foundation

enum NetworkError: Error {
    
    case apiError
    case noData
    case convertError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .noData: return "No data"
        case .convertError: return "Failed to decode data"
        }
    }
}
