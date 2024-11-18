//
//  BurgerNetWork.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 15/01/2024.
//

import UIKit

class BurgerNetWork {
    
    enum DataError: Error {
        case invalidData
        case ivalidResponse
        case message(_ error: Error?)
    }

    static let shared = BurgerNetWork()
     init() {}
    
    let urlString = "https://burgers-hub.p.rapidapi.com/burgers"
    
  
    func fetchData(completion: @escaping (Result<[Element], Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let headers = [
            "X-RapidAPI-Key": "9dedb7d073msh89ba359570b9d54p18e087jsncf0c1ef58dbd",
            "X-RapidAPI-Host": "burgers-hub.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { completion(.failure(DataError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200...209 ~= response.statusCode else {
                completion(.failure(DataError.ivalidResponse))
                return
            }
            do {
                let products = try JSONDecoder().decode([Element].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(DataError.message(error)))
            }
        }.resume()
          
    }
}



