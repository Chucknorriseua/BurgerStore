//
//  LoginEnterViewController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 08/07/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct LoginSignInViewController: View {
    
    @State private var isShowAlert = false
    @State private var isShowView = false
    @State private var messageAlert = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var animation = 1.0
    @StateObject var signInViewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image("BurgerCell")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle()).shadow(color: Color.white, radius: 30)
                    
                }.overlay(Circle()
                    .stroke(Color.white)
                    .scaleEffect(animation)
                    .opacity(2 - animation)
                  
                          
                )
                .onAppear(perform: {
                    animation = 2
                })
                
                VStack {
                        
                        CustomTextField(text: $signInViewModel.email, title: "Email", width: UIScreen.main.bounds.width - 20, showPassword: $signInViewModel.showPassword)
        
                        CustomTextField(text: $signInViewModel.password, title: "Password", width: UIScreen.main.bounds.width - 20, showPassword: $signInViewModel.showPassword)
              
                    
                    Button(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                                logIn()
                        }
                        
                    }, label: {
                        
                        HStack {
                            Text("Sign In")
                            Image(systemName: "arrow.right.to.line.alt")
                        }
                        
                    })
                    .padding()
                    .frame(width: 280)
                    .foregroundStyle(.black)
                    .background(Color(hex: "F3E3CE"))
                    .clipShape(.rect(cornerRadius: 24))
                    .font(.title2.bold())
                    .padding()
                    .disabled(!formValid)
                    .opacity(formValid ? 1.0 : 0.5)
                    
                    Text("Or").font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color(hex: "F3E3CE"))
                    
                    HStack {
                        Image("Logo Apple")
                        Image("Logo Email")
                        Image("Logo Google")
                        
                    }.padding(.bottom, 5)
                    
                    
                    NavigationLink {
                        
                        LoginRegisteView()
                            .navigationBarBackButtonHidden(true)
                        
                    } label: {
                        
                        Text("Dont Have an Account Sign up")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color(hex: "F3E3CE"))
                    }
                    
                }.frame(width: 380, height: 400).background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 4))
                
            }.background(Image("1111").resizable().scaledToFill().frame(height: 900))
            .animation(.easeOut(duration: 1).repeatForever(autoreverses: true), value: animation)
            .keyboardHeight($keyboardHeight)
            .offset(y: -keyboardHeight / 6)
        }
        
        .fullScreenCover(isPresented: $isShowView, content: {
            LoginSignInViewControllerRepresentables.init().ignoresSafeArea(.container)
        })
        
        .alert(messageAlert, isPresented: $isShowAlert) {
            
            Button(action: {}, label: {
                Text("OK")
            })
        }

    }
    func logIn() {
        
        AuthService.shared.sigIn(email: signInViewModel.email, password: signInViewModel.password) { result in
                switch result {
                case .success(_):
                    print("Hello user")
                    
                    isShowView.toggle()
                case .failure(let error):
                    self.isShowAlert.toggle()
                    self.messageAlert = "This user does not exist, or the email and password were entered incorrectly.🫤"
                    print("Not found current users", error.localizedDescription)
                }
            }
    }
}

@available(iOS 16.0, *)
extension LoginSignInViewController: FormValidProtocol {
    var formValid: Bool {
        return !signInViewModel.email.isEmpty &&
        signInViewModel.email.contains("@gmail.com")
        && !signInViewModel.password.isEmpty
        && signInViewModel.password.count > 5
    }
}

@available(iOS 16.0, *)
struct LoginSignInViewControllerRepresentables: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BurgerTabBarController {
        let vc = BurgerTabBarController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: BurgerTabBarController, context: Context) {
        
    }
    
    typealias UIViewControllerType = BurgerTabBarController
    
    struct LoginViewContro: PreviewProvider {
        static var previews: some View {
            LoginSignInViewControllerRepresentables()
        }
    }
}


@available(iOS 16.0, *)
#Preview {
    LoginSignInViewController()
}
