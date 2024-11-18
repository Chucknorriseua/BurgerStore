//
//  RecomCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 14/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI



struct RecomCell: View {
    @State var product: BurgerModel
    @State var count = 1
    
    var body: some View {
        VStack {
            
            VStack {
                ForEach(product.images ?? [], id: \.self) { image in
                    
                    if (image.sm != nil) {
                        WebImage(url: URL(string: image.sm ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(.rect(cornerRadius: 12))
                        
                    } else {
                        Image("")
                        
                    }
                }
                
                VStack {
                    Text("\(product.name ?? "")")
                        .lineLimit(3)
                        .frame(width: 100, height: 50)
                    
                    HStack(spacing: 50) {

                        Text("\(Int(product.price ?? 0.0))$")
                        Button(action: {
                            let product = ShopModel(id: UUID().uuidString, product: product, count: self.count)
                            ShoppViewModel.shared.addProductCart(product)
                            
                        }, label: {
                            Image(systemName: "plus.app.fill")
                                .font(.system(size: 18))
                        })
                        
                    }
                    
                }
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(Color.white)
                //                may clear frame
            }.frame(width: 160, height: 180)
            
        }.background(Color(red: 0.10, green: 0.11, blue: 0.12))
    }
}

#Preview {
    RecomCell(product: BurgerModel(id: 0, name: "", images: [], desc: "", ingredients: [], price: 0.0, veg: false))
}
