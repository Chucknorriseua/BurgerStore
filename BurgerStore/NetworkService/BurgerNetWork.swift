//
//  BurgerNetWork.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 15/01/2024.
//

import UIKit

@MainActor
class BurgerNetWork: ObservableObject {
    
    enum DataError: Error {
        case invalidData
        case ivalidResponse
        case message(_ error: Error?)
    }

    static let shared = BurgerNetWork()
     init() {}
    
    let urlString = "https://burgers-hub.p.rapidapi.com/burgers"
    let urlChinaFood = "https://chinese-food-db.p.rapidapi.com/"
    
  
    func fetchData(completion: @escaping (Result<[BurgerModel], Error>) -> Void) {
        
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
                let products = try JSONDecoder().decode([BurgerModel].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(DataError.message(error)))
            }
        }.resume()
          
    }
    
    func fetchAllChinaFood() async throws -> [ChinafoodElement] {
        
        guard let url = URL(string: urlChinaFood) else { throw DataError.invalidData }
        
        
        let headers = [
            "X-rapidapi-Key": "9dedb7d073msh89ba359570b9d54p18e087jsncf0c1ef58dbd",
            "X-rapidapi-Host": "chinese-food-db.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DataError.ivalidResponse
        }
        guard let decoder = try? JSONDecoder().decode([ChinafoodElement].self, from: data) else {
            throw DataError.invalidData
        }
        
        return decoder
    }
}



