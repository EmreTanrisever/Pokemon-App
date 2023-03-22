//
//  BaseRequestModel.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import Foundation

protocol BaseRequestModelInterface {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [String: Any] { get }
}

class BaseRequestModel: BaseRequestModelInterface {

    var schema: String {
            "https"
        }
        
        var host: String {
            "api.themoviedb.org"
        }
        
        var path: String {
            ""
        }
        
        var queryItems: [String : Any] {
            [:]
        }
    
    func createURL(with pokemonID: Int?) -> URLRequest? {
        var component = URLComponents()
        component.scheme = schema
        component.host = host
        var items: [URLQueryItem] = []
        
        var pathWithID = ""
        
        if let id = pokemonID {
            pathWithID = "\(path)/\(id)"
            component.path = pathWithID
        } else {
            component.path = path
            
        }
        
        for (key, value) in queryItems {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            items.append(queryItem)
        }

        component.queryItems = items
        
        if let url = component.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}
