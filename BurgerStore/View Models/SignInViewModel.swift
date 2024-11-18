//
//  SignInViewModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 09/07/2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showPassword: Bool = false
    @Published var fullName: String = ""

    @Published  var isAnimation: Bool = false


}
