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

func fetchData(completion: @escaping ([Products]) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}

    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if error != nil {
            print("Ошибка сети")
            return
        }

        guard let data = data else {return}

        do {
            let decodedProducts = try JSONDecoder().decode([Products].self, from: data)

            completion(decodedProducts)

        } catch {
            print("Error parc info")
        }
    }

    task.resume()

}
