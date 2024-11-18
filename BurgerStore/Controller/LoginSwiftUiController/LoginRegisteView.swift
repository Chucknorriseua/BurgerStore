//
//  LoginRegisteView.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 19/06/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct LoginRegisteView: View {

    @StateObject var signInViewModel = SignInViewModel()
    @State private var isAuth = false
    @State private var messageAlert = ""
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                VStack {
                    VStack(alignment: .center, spacing: 15) {
                        CustomTextField(text: $signInViewModel.email, title: "Email", width: UIScreen.main.bounds.width - 20, showPassword: $signInViewModel.showPassword)
                        
                        CustomTextField(text: $signInViewModel.fullName, title: "Full Name", width: UIScreen.main.bounds.width - 20, showPassword: $signInViewModel.showPassword)
                        
                        CustomTextField(text: $signInViewModel.password, title: "Password", width: UIScreen.main.bounds.width - 20, showPassword: $signInViewModel.showPassword)
                        
                        CustomTextField(text: $signInViewModel.confirmPassword, title: "Confirm Password", width: UIScreen.main.bounds.width - 20, showPassword: $signInViewModel.showPassword)
                    }
                    
                    Button(action: {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            signUp()
                            mode.wrappedValue.dismiss()
                        }
                    }, label: {
                        
                        Text("Register to login")
                            .padding()
                            .frame(width: 280)
                            .foregroundStyle(.black)
                            .background(Color(hex: "F3E3CE"))
                            .clipShape(.rect(cornerRadius: 22))
                            .font(.title2.bold())
                            .padding()
                        
                    })
                    .disabled(!formValid)
                    .opacity(formValid ? 1.0 : 0.5)
                    
                  
                    
                }
                .frame(width: 380, height: 380)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
                
                VStack {
                    Button(action: {
                        mode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "arrow.left.to.line")
                        Text("Back to Sign In")
                    }).foregroundStyle((Color(hex: "##fdebb5")))
                      .font(.title2.bold())
                }
                
            }.background(Image("1111").resizable()
                .scaledToFill()
                .frame(height: 1000)
            )
            
        }
    }
    
    func signUp() {
        
        AuthService.shared.signUp(email: signInViewModel.email, password: signInViewModel.password, fullName: signInViewModel.fullName) { result in
            switch result {
            case .success(let user):
                print("User is here \(user.email ?? "")")
                
            case .failure(let error):
                self.messageAlert = "Not corretct registration\(error.localizedDescription)"
                print("Error ", error.localizedDescription)
            }
        }
        
        self.signInViewModel.email = ""
        self.signInViewModel.password = ""
        self.signInViewModel.confirmPassword = ""
        self.signInViewModel.fullName = ""
        self.isAuth.toggle()
    }
}

@available(iOS 16.0, *)
extension LoginRegisteView: FormValidProtocol {
    var formValid: Bool {
        return !signInViewModel.email.isEmpty &&
        signInViewModel.email.contains("@gmail.com")
        && !signInViewModel.password.isEmpty
        && signInViewModel.password.count > 5
        && signInViewModel.confirmPassword == signInViewModel.password
    }
    
    
}

@available(iOS 16.0, *)
#Preview {
    LoginRegisteView()
}
