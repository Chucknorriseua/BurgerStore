//
//  MainBurgerCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 11/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI


@available(iOS 16.0, *)
struct MainBurgerCell: View {
    
    
    @State var product: BurgerModel
    @State var count = 1
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            productCard()
            
        }.frame(width: 380, height: 280)
            .background(Color(red: 0.10, green: 0.11, blue: 0.12))
            .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder
    private func productCard() -> some View {
        Color.clear
            .overlay {
                ZStack {
                    ForEach(product.images ?? [], id: \.self) { image in
                        if (image.sm != nil) {
                            WebImage(url: URL(string: image.sm ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 210, height: 260)
                                .clipShape(.rect(cornerRadius: 12))
                                .offset(CGSize(width: 80, height: 2.0))
                        } else {
                           Image("")
                            
                        }
                    }
                    
                    HStack {
                        VStack(spacing: 18) {
                            Text("\(product.name ?? "")")
                                .fontWeight(.heavy)
                            
                            VStack(spacing: -16) {
                                Text("$\(Int(product.price ?? 0.0))")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Text("_____")
                            }
                            
                            //                    Button
                            Button(action: {
                                let product = ShopModel(id: UUID().uuidString, product: product, count: self.count)
                                
                                ShoppViewModel.shared.addProductCart(product)
                           
                                mode.wrappedValue.dismiss()

                            }, label: {
                                Text("Buy it")
                                    .fontWeight(.heavy)
                            }).frame(width: 80, height: 34)
                                .background(Color.yellow)
                                .clipShape(.rect(cornerRadius: 12))
                                .foregroundStyle(Color.white)
                            
                            
                        }.frame(maxWidth: 170, maxHeight: 200)
                            .foregroundStyle(Color.yellow)
                        Spacer()
                        
                    }.padding(.leading, 4)
                    
                    HStack {
                        Image("burgero")
                            .resizable()
                            .scaledToFit()
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 30, height: 30)
                        Image("bacon")
                            .resizable()
                            .scaledToFit()
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 30, height: 30)
                        Image("cheese")
                            .resizable()
                            .scaledToFit()
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 30, height: 30)
                        Image("tomato")
                            .resizable()
                            .scaledToFit()
                            .background(Color.white)
                            .clipShape(.rect(cornerRadius: 12))
                            .frame(width: 30, height: 30)
                        
                    }.frame(minHeight: 260, alignment: .bottomLeading)
                        .padding(.trailing, 200)
                }
            }
    }
}
@available(iOS 16.0, *)
#Preview {
    MainBurgerCell(product: BurgerModel(id: 0, name: "", images: [], desc: "", ingredients: [], price: 0.0, veg: false))
}
