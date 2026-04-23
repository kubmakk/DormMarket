//
//  NetworkMagaer.swift
//  DormMarket
//
//  Created by kubmakk on 01.04.2026.
//

import UIKit

struct Products: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String

}

enum APIEndpoints {
    case posts
    case users
    case image(id: String)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        switch self {
        case .posts: components.path = "/posts"
        case .users: components.path = "/users"
        case .image(let id): components.path = "/images/\(id)"
        }
        return components.url
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func fetchData<T: Codable>(endpoint: APIEndpoints) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard (responce as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
        

    }



