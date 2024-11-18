//
//  ChinaFoodCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 17/06/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChinaFoodCell: View {
    
    @State var chinaProduct: ChinafoodElement
    @State var count = 1
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if let imageName = chinaProduct.image, let uiImage = URL(string: imageName) {
                WebImage(url: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 360, height: 220)
            } else {
                
            }
//    
//            AsyncImage(url: URL(string: chinaProduct.image ?? "")) { phase in
//                
//                switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                    image.resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(maxWidth: 360, maxHeight: 220)
//                case .failure:
//                    Image(systemName: "photo")
//                @unknown default:
//                    EmptyView()
//                }
//            }
            
            VStack {
                Text("\(chinaProduct.title)")
                    .lineLimit(3)
                    .frame(width: 220, height: 50)
                    .background(Color.black)
                    .clipShape(.rect(cornerRadius: 16))
                    .padding(.all, 2)
                    .foregroundStyle(Color.yellow)
                    .font(.system(size: 16, weight: .bold))
                
                HStack(spacing: 50) {
                    Text("12$")
                        .foregroundStyle(Color.yellow)
                        .font(.system(size: 18, weight: .heavy))
                        .padding(.all, 4)
                    
                    Button {
                        let product = ChinaShopModel(id: UUID().uuidString, product: chinaProduct, count: self.count)
                        
                        ShoppViewModel.shared.addChinaProduct(product)
                        
                    } label: {
                        
                       Image(systemName: "plus.app.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(Color.yellow)
                    }
                    .padding(.all, 4)
                }
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 12))
               
            }
            
        }.frame(width: 360, height: 320)
        .border(Color(red: 0.87, green: 0.83, blue: 0.78), width: 2)
            .clipShape(.rect(cornerRadius: 2))
           
    }
}

#Preview {
    ChinaFoodCell(chinaProduct: ChinafoodElement(id: "", title: "", difficulty: "", image: ""))
}
