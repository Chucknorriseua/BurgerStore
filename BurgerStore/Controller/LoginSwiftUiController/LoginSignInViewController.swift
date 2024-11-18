//
//  LoginEnterViewController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 08/07/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct LoginSignInViewController: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("BurgerCell")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle()).shadow(color: Color.white, radius: 30)
            }
            
            VStack {
                InputView(text: $email,
                          title: "Email",
                          placeholder: "@gmail.com",
                          isSecureField: false)
                    .textInputAutocapitalization(.none)
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your paswword",
                          isSecureField: true)
                
            }.frame(width: 360, height: 400).background(Color.gray)
            
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
@available(iOS 16.0, *)
#Preview {
    LoginSignInViewController()
}
