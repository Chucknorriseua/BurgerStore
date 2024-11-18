//
//  RecomChina.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 18/06/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct RecomChina: View {
    
    @State var product: [ChinafoodElement] = []
    
    let rows = [
        GridItem(.fixed(50)),
        //        GridItem(.fixed(150))
    ]
    
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal) {
                
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(product, id:\.self) { product in
                        RecomChinaCell(product: product)
                    }
                }
                
            }.scrollIndicators(.hidden)
            
            
                .onAppear(perform: {
                    Task {
                        await fetchAllProductChina()
                    }
                })
        }.background(Color(red: 0.10, green: 0.11, blue: 0.12))
        
        
    }
    func fetchAllProductChina() async {
        do {
            product = try await BurgerNetWork.shared.fetchAllChinaFood()
        } catch {
            print(error.localizedDescription)
        }
    }
}
@available(iOS 16.0, *)
#Preview {
    RecomChina()
}
