//
//  BurgerDetailsView.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 18/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI


@available(iOS 16.0, *)
struct BurgerDetailsView: View {
    
    @Environment(\.presentationMode) var mode
    
    @State var product: BurgerModel
    @State var count = 1
    
    var body: some View {
        
        VStack {
            ScrollView {
                
                Button {
                    mode.wrappedValue.dismiss()
                    
                } label: {
                    Image(systemName: "clear.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.gray)
                    
                }.frame(maxWidth: .infinity, alignment: .topTrailing)
                    .padding(.trailing, 8)
  
            
                VStack {
                    ForEach(product.images ?? [], id:\.sm) { image in
                        
                        if (image.sm != nil) {
                            WebImage(url: URL(string: image.sm ?? ""))
                                .resizable()
                                .frame(width: 340, height: 340)
                                .scaledToFill()
                                .cornerRadius(12)
                        } else {
                            Image("")
                        }
                    }
                    
                    
                }.padding(.top)
                
                HStack(alignment: .firstTextBaseline ,spacing: 10) {
                    Text(product.name ?? "")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.white)
                    
                    HStack(spacing: 5) {
                        Text("$\(Int(product.price ?? 0.0))")
                            .font(.system(size: 22, weight: .bold).italic())
                            .foregroundStyle(Color.white)
                        
                    }
                    
                }
                Divider().background(Color.white)
                    .padding(.bottom, 10)
                
                
                VStack {
                    Text(product.desc ?? "")
                    
                        .font(.system(size: 22, weight: .medium, design: .serif))
                        .lineLimit(40)
                        .frame(width: 350)
                        .frame(alignment: .center)
                        .foregroundStyle(Color.white)
                }
                
                Divider().background(Color.white)
                
                HStack {
                    ScrollView(.horizontal) {
                        BurgerIngredients(ingriedient: product)
                    }.scrollIndicators(.hidden)
                }
                
            }.scrollIndicators(.hidden)
            
            CustomMainButton(title: "Buy") {
                let product = ShopModel(id: UUID().uuidString, product: product, count: self.count)
                ShoppViewModel.shared.addProductCart(product)
            }
            
        }.background(Color(red: 0.10, green: 0.11, blue: 0.12))
        
    }
}
@available(iOS 16.0, *)
#Preview(body: {
    BurgerDetailsView(product: BurgerModel(id: 0, name: "", images: [], desc: "", ingredients: [], price: 0.0, veg: false))
})
