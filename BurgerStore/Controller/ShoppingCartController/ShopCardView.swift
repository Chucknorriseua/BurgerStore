//
//  ShopCardView.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 26/01/2024.
//

import SwiftUI


//MARK: Table View info
struct ShopCardView: View {
    
    @StateObject var viewModel: CartManager

    var body: some View {
     VStack {
            
    ScrollView {
        //           MARK: Burger Cell
        if !animation {
            
            LazyVStack {
                ForEach(viewModel.shopViewModel, id:\.self) { item in
                    
                    ShopProductViewCell(shopModel: item, viewModel: ShoppViewModel.shared)
                }
                //            MARK: China Food Cell
                ForEach(viewModel.chinaViewModel, id:\.self) { item in
                    ShopProductChinaCell(viewModel: ShoppViewModel.shared, chinaModel: item)
                }
            }.animation(.easeOut(duration: 5), value: animation)
        }
         
        
        VStack {
            //        MARK: Recommend Burgers
            RecomBurger()
            //        MARK:   Recommend China Food
            RecomChina()
                .padding(.top, 60)
            
        }
                
            }
            .background(Color(red: 0.10, green: 0.11, blue: 0.12))
            .scrollContentBackground(.hidden)
            .navigationBarHidden(true)
            
            VStack {
                BuyButtonView(viewModel: ShoppViewModel.shared)
            }.padding(.bottom, 15)
            
        }.background(Color(red: 0.10, green: 0.11, blue: 0.12))
        
    }
}

#Preview {
    ShopCardView(viewModel: CartManager.shared)
}
