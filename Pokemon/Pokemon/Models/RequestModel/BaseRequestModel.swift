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
        "pokeapi.co"
    }
    
    var path: String {
        ""
    }
    
    var queryItems: [String : Any] {
        [:]
    }
    
    func createURL(with typeOfPath: Any?) -> URLRequest? {
        var component = URLComponents()
        component.scheme = schema
        component.host = host
        var items: [URLQueryItem] = []
        
        
        if let typeOfPath = typeOfPath {
            if path.contains("ability") {
                guard let id = typeOfPath as? Int else { return nil}
                component.path = createNewPath(id: id)
            } else {
                guard let name = typeOfPath as? String else { return nil}
                component.path = createNewPath(name: name)
            }
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
    
    private func createNewPath(name: String) -> String {
        return "\(path)/\(name)"
    }
    
    private func createNewPath(id: Int) -> String {
        return "\(path)/\(id)"
    }
}
