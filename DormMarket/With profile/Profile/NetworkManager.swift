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
    var image: String
    var useridImage: String
    let title: String
    var body: String

}

enum APIEndpoints {
    case posts
    case users
    
    var path: String {
        switch self {
        case .posts: return "/posts"
        case .users: return "/users"
        }
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "vpn.kubmakk.ru"
        components.path = "/api/\(self)"
        return components.url
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func fetchData<T: Codable>(endpoint: APIEndpoints) async throws -> T {
        guard let url = endpoint.url else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
                // h2 = HTTP/2, http/1.1 = HTTP/1.1, h3 = HTTP/3
                print("Protocol: \(httpResponse.value(forHTTPHeaderField: "X-Apple-Network-Protocol") ?? "unknown")")
            }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    
}
