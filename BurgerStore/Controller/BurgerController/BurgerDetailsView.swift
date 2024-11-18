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
    @State var isPresent = false
    
   @State var productss: Element
   @State var ingrys: Ingredient?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    VStack() {
                        ForEach(productss.images ?? [], id:\.sm) { image in
                      
                            if (image.sm != nil) {
                                WebImage(url: URL(string: image.sm ?? ""))
                                    .resizable()
                                    .frame(width: 380, height: 340)
                                    .scaledToFill()
                                    .cornerRadius(12)
                            } else if image.lg == nil {
                                Image("")
                            }
                        }
                    }
                }.padding(.top)
                Divider().background(Color.black)
                
                HStack(alignment: .firstTextBaseline ,spacing: 5) {
                    Text(productss.name ?? "")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.black)
                       
                    HStack {
                        Text("$\(Int(productss.price ?? 0.0))")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding(.all, 5)
   
                    }.background(Color.green)
                        .cornerRadius(10)

                }
                Divider().background(Color.black)
                
                    .padding(.bottom, 10)
                VStack {
                    Text(productss.desc ?? "")
                    
                        .font(.system(size: 22, weight: .medium, design: .serif))
                        .lineLimit(40)
                        .frame(width: 350)
                        .frame(alignment: .center)
                        .foregroundColor(Color.black)
                }
                Divider().background(Color.black)
                
                HStack {
                    ScrollView(.horizontal) {
                        BurgerIngredients(ingriedient: productss)
                    }.scrollIndicators(.hidden)
                }
//                .padding(.all)
            }.scrollIndicators(.hidden)
        }.background(Color("late"))
            .onTapGesture {
                mode.wrappedValue.dismiss()
            
            }
    }
}

@available(iOS 16.0, *)
struct BurgerDetailsViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BurgerTabBarController {
        let vc = BurgerTabBarController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BurgerTabBarController, context: Context) {

    }
    
    typealias UIViewControllerType = BurgerTabBarController
    
    struct LoginViewContro: PreviewProvider {
        static var previews: some View {
            BurgerDetailsViewRepresentable()
        }
    }
}

@available(iOS 16.0, *)
struct BurgerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BurgerDetailsView(productss: Element(id: 3, name: "", images: [], desc: "", ingredients: [], price: 1, veg: false), ingrys: Ingredient(id: 1, name: "", img: URL(string: "")))
            
    }
}
