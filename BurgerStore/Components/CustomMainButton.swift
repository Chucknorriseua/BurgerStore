//
//  CustomMainButton.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 31/07/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct CustomMainButton: View {
    
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
            
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color(red: 0.11, green: 0.14, blue: 0.12))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 8)
        })
        .padding()
    }
}
