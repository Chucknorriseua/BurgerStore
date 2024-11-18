//
//  RecomChinaCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 18/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecomChinaCell: View {
    @State var product: ChinafoodElement
    @State var count = 1
    
    var body: some View {
        VStack {
            
            VStack {
                if let imageName = product.image, let uiImage = URL(string: imageName) {
                    WebImage(url: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(.rect(cornerRadius: 12))
                } else {
                    
                }
                
                VStack {
                    Text("\(product.title)")
                        .lineLimit(3)
                        .frame(width: 100, height: 50)
                    
                    HStack(spacing: 50) {
                        Text("5$")
                        Button(action: {
                            withAnimation(.snappy(duration: 0.3)) {
                                let product = ChinaShopModel(id: UUID().uuidString, product: product, count: self.count)
                                ShoppViewModel.shared.addChinaProduct(product)
                                
                            }
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
    RecomChinaCell(product: ChinafoodElement(id: "", title: "", difficulty: "", image: ""))
}
