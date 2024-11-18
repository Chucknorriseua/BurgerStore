//
//  BurgerIngredients.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 18/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct BurgerIngredients: View {
    
    let ingriedient: BurgerModel?
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                ForEach(ingriedient?.ingredients ?? [], id:\.self) { image in
                    WebImage(url: image.img)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .cornerRadius(22)
                }.shadow(color: Color.black, radius: 10)
            }
        }.padding(.all)
    }
}

struct BurgerIngredients_Previews: PreviewProvider {
    static var previews: some View {
        BurgerIngredients(ingriedient: BurgerModel(id: 4, name: "burger", images: [], desc: "dsdds", ingredients: [], price: 24, veg: true))
    }
}
