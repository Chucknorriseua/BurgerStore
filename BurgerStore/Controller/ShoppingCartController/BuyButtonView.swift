//
//  BuyButtonView.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 20/06/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct BuyButtonView: View {
    @StateObject var viewModel: ShoppViewModel
    @State var isShowAlert = false
    
    var body: some View {
        
        HStack {
            
            CustomMainButton(title: "Total sum:   \(viewModel.total)$,    Buy") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    if viewModel.shopViewModel.count > 0 {
                        var order = Order(userId: AuthService.shared.currentUser!.uid, date: Date(), status: OrderStatus.complete.rawValue)
                        
                        order.shopModel = self.viewModel.shopViewModel
                        
                        DataBaseService.shared.setOrder(order: order) { result in
                            switch result {
                            case .success(let order):
                                
                                viewModel.shopViewModel.removeAll()
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    if viewModel.chinaViewModel.count > 0 {
                        var chinaOrder = OrderChina(userId: AuthService.shared.currentUser!.uid, date: Date(), status: OrderStatus.complete.rawValue)
                        
                        chinaOrder.chinaShop = self.viewModel.chinaViewModel
                        
                        DataBaseService.shared.setOrdeChina(order: chinaOrder) { result in
                            switch result {
                            case .success(let order):

                                viewModel.chinaViewModel.removeAll()
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                    if viewModel.shopViewModel.count > 0 || viewModel.chinaViewModel.count > 0 {
                        NotificationController.sharet.notify(title: "Burger Company", subTitle: "Thank you for your purchase. Your order is currently being processed ❤️❤️❤️", timeInterval: 2)
                    }
                }
            }
        }
    }
}
@available(iOS 16.0, *)
#Preview {
    BuyButtonView(viewModel: ShoppViewModel.shared)
}
