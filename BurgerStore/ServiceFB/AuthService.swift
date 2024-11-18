//
//  AuthService.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 30/01/2024.
//

import UIKit
import FirebaseAuth

protocol FormValidProtocol {
    var formValid: Bool {get}
}

class AuthService {
    
    static let shared = AuthService()
    
    private init() { }
    
    let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
//MARK: Регистрация пользователя и его данных на ФБ
    func signUp(email: String, password: String, fullName: String, completion: @escaping (Result <User, Error>)-> Void) {
       auth.createUser(withEmail: email, password: password) { result, error in
           if let result = result {
               
               let mwUser = MwUser(id: result.user.uid, fullName: fullName, phone: "", adress: "", city: "", numberHome: "")
               DataBaseService.shared.setUser(user: mwUser) { resultdb in
                   switch resultdb {
                       
                   case .success(_):
                       completion(.success(result.user))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
           } else if let error = error {
               completion(.failure(error))
           }
        }
    }
    
    func sigIn(email: String, password: String, completion: @escaping (Result <User, Error>)-> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
    }
}
