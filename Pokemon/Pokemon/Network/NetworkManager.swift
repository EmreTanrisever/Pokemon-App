//
//  Networkmanager.swift
//  Pokemon
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import Foundation

protocol NetworkManagerInterface {
    
    func sendRequest<T: Codable>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T, NetworkError>) -> Void
    )
}

final class NetworkManager: NetworkManagerInterface {
    
    private let urlSession = URLSession.shared
    static let shared = NetworkManager()
}

extension NetworkManager {
    
    func sendRequest<T>(
        urlRequest: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T : Decodable, T : Encodable {
        urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.returnCompletionHandler(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let data = data else {
                self.returnCompletionHandler(with: .failure(.noData), completion: completion)
                return
            }
            
            guard let decodedData = self.convertData(T.self, data: data) else {
                self.returnCompletionHandler(with: .failure(.convertError), completion: completion)
                return
            }
            
            self.returnCompletionHandler(with: .success(decodedData), completion: completion)
        }.resume()
    }
    
    private func convertData<T: Decodable>(_ type: T.Type, data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try jsonDecoder.decode(type, from: data)
            return data
        } catch {
            return nil
        }
    }
    
    private func returnCompletionHandler<T: Codable>(with result: Result<T, NetworkError>, completion: @escaping(Result<T, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
