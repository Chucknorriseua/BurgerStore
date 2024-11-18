//
//  RecomBurger.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 14/06/2024.
//

import SwiftUI

@available(iOS 16.0, *)

struct RecomBurger: View {
    
    @State var product: [BurgerModel] = []

    let rows = [
        GridItem(.fixed(50)),
//        GridItem(.fixed(150))
    ]

    
    var body: some View {
        VStack(alignment: .center) {
            Text("We also recommend")
                .foregroundStyle(Color(red: 0.87, green: 0.83, blue: 0.78))
                .font(.system(size: 22, weight: .bold))
            
            ScrollView(.horizontal) {

                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(product, id:\.self) { product in
                        RecomCell(product: product)
                    }
                }
                
            }.scrollIndicators(.hidden)
            
        }.background(Color(red: 0.10, green: 0.11, blue: 0.12))
        
            .onAppear(perform: {
                BurgerNetWork.shared.fetchData { results in
                    switch results {
                    case .success(let product):
                        self.product = product
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            })
    }
}

@available(iOS 16.0, *)
#Preview {
    RecomBurger()
}
