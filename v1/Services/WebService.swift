//
//  WebService.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation


enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
}

class Webservice {
    //Result type (.success, .faulure)
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) async throws {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            guard let data = data, error == nil else {
//                completion(.failure(.domainError))
//                return
//            }
//
//            let result = try? JSONDecoder().decode(T.self, from: data)
//            if let result = result {
//                DispatchQueue.main.async {
//                    //pass to the UI
//                    completion(.success(result))
//                }
//            } else {
//                completion(.failure(.decodingError))
//            }
//
//        }.resume()
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let result = try? JSONDecoder().decode(T.self, from: data)
        if let result = result {
            print(result)
            DispatchQueue.main.async {
                //pass to the UI
                completion(.success(result))
            }
        } else {
            completion(.failure(.decodingError))
        }
    }
}
