//
//  ShopCardView.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 26/01/2024.
//

import SwiftUI
import FirebaseFirestore

//MARK: Table View info
@available(iOS 16.0, *)
struct ShopCardView: View {
    
    @StateObject var viewModel: ShoppViewModel
    
    var body: some View {
        VStack {

            ScrollView {
                //           MARK: Burger Cell
                LazyVStack {
                    ForEach($viewModel.shopViewModel.indices, id:\.self) { index in
                        
                        ShopProductViewCell(viewModel: ShoppViewModel.shared, shopModel: $viewModel.shopViewModel[index])
                    }
                }
                
                LazyVStack(alignment: .center) {

                    ForEach($viewModel.chinaViewModel.indices, id:\.self) { item in

                        ShopProductChinaCell(viewModel: ShoppViewModel.shared, chinaModel: $viewModel.chinaViewModel[item])
                    }
                }
                
                VStack {
                    //        MARK: Recommend Burgers
                    RecomBurger()
                    //        MARK:   Recommend China Food
                    RecomChina()
                        .padding(.top, 60)
                    
                }.background(Color(red: 0.10, green: 0.11, blue: 0.12))
                
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
@available(iOS 16.0, *)
#Preview(body: {
    ShopCardView(viewModel: ShoppViewModel.shared)
})
