//
//  ShopProductViewCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 09/05/2024.
//

import SwiftUI

struct ShopProductViewCell: View {
    var body: some View {
        ZStack {
            VStack {
                
                HStack(alignment: .center ,spacing: 6) {
                    
                    HStack {
                        ForEach(shopModel.product.images ?? [], id:\.self) { image in
                            
                            if (image.sm != nil) {
                                WebImage(url: URL(string: image.sm ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.rect(cornerRadius: 12))
                                    .frame(width: 60, height: 60)
                                
                            } else {
                                Image("")
                                
                            }
                        }
                    }
                    
                    VStack(spacing: 8) {
                        
                        HStack {
                            Text(shopModel.product.name ?? "")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(Color(red: 0.87, green: 0.83, blue: 0.78))
                        }
                        HStack {
                            
                            if let productPrice = shopModel.product.price {
                                let sum = productPrice * Double(shopModel.count)
                                
                                Text("\(Int(sum))$")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(Color(red: 0.87, green: 0.83, blue: 0.78))
                                
                            }
                        }
                    }.frame(maxWidth: 180)
                    
                    
                    HStack(spacing: 4) {
                        
                        Button(action: {
                            
                            shopModel.count -= 1
                            viewModel.minusTotal(shopModel: shopModel)
                            
                        }, label: {
                            Image(systemName: "minus.square.fill")
                                .font(.system(size: 26))
                                .foregroundStyle(Color.white)
                        })
                        
                        
                        
                        Button(action: {
                            
                            shopModel.count += 1
                            viewModel.plusTotal(shopModel: shopModel)
                            
                        }, label: {
                            Image(systemName: "plus.square.fill")
                                .font(.system(size: 26))
                                .foregroundStyle(Color.white)
                        })
                        
                        HStack {
                            Text("\(shopModel.count)")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundStyle(Color(red: 0.87, green: 0.83, blue: 0.78))
                            
                        }.onChange(of: shopModel.count, perform: { newValue in
                            shopModel.count = min(max(newValue, 1), 10)
                            
                        })
                        
                    }.padding(.top, 80)
                     .padding(.trailing, 20)
                }
            }
            
            HStack {
                
                Button(action: {
                    viewModel.removeProductItem(at: shopModel)
                    
                }, label: {
                    Image(systemName: "clear.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.white)
                })
                
            }.frame(maxWidth: .infinity, maxHeight: 120, alignment: .topTrailing)
        }
    }
}

#Preview {
    ShopProductViewCell()
}
