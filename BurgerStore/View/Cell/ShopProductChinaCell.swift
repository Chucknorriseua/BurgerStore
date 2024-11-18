//
//  ShopProductChinaCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 18/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShopProductChinaCell: View {
    
    @StateObject var viewModel = ShoppViewModel()
    @Binding var chinaModel: ChinaShopModel
    
    var body: some View {
        ZStack {
            
            HStack(spacing: 4) {
                
                if let imageName = chinaModel.product.image, let uiImage = URL(string: imageName) {
                    WebImage(url: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(.rect(cornerRadius: 12))
                } else {
                    EmptyView()
                }
                
                HStack {
                    
                    Text("\(chinaModel.product.title)")
                    
                    Text("\(chinaModel.price)")
                    
                }.frame(width: 180)
                    .foregroundStyle(Color(red: 0.87, green: 0.83, blue: 0.78))
                    .font(.system(size: 18, weight: .bold))
                
                HStack(spacing: 4) {
                    
                    Button(action: {
                    
                            viewModel.minusTotalChina(shopModel: chinaModel)
                        
                    }, label: {
                        Image(systemName: "minus.square.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(viewModel.changeColorMinus(value: chinaModel.count))
                    }).disabled(chinaModel.count == 1)
                    
                    
                    
                    Button(action: {
                        
                        viewModel.plusTotalChina(shopModel: chinaModel)
                        
                    }, label: {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(viewModel.changeColorPlus(value: chinaModel.count))
                    }).disabled(chinaModel.count >= 10)
                    
                    HStack {
                        Text("\(chinaModel.count)")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundStyle(Color(red: 0.87, green: 0.83, blue: 0.78))
                        
                    }
                }
            }.padding(.top, 40)
                .padding(.trailing, 20)
            
            HStack {
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.4)) {
                        
                        viewModel.removeProductChinaItem(at: chinaModel)
                    }
                    
                }, label: {
                    Image(systemName: "clear.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.white)
                })
                
            }.frame(maxWidth: .infinity, maxHeight: 120, alignment: .topTrailing)
        }
    }
}
