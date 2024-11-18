//
//  ProfileUserViewController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 08/07/2024.
//

import SwiftUI
import FirebaseAuth

@available(iOS 16.0, *)
struct ProfileUserViewController: View {
    
    @StateObject var viewModel: ProfileViewModel
    @State var isOut = false
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        if let user = AuthService.shared.currentUser {
            
            List {
                Section {
                    HStack {
                        Text("CN")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(Color.gray)
                            .clipShape(Circle(), style: FillStyle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.profile.fullName)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email ?? "")
                                .font(.footnote)
                                .tint(.gray)
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        Image(systemName: "gear")
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.gray)
                    }
                }
                
                Section {
                    TextField("", text: $viewModel.profile.phone, prompt: Text("Phone").foregroundColor(Color.secondary)).frame(height: 40)
                    TextField("", text: $viewModel.profile.city, prompt: Text("City").foregroundColor(Color.secondary)).frame(height: 40)
                    TextField("", text: $viewModel.profile.adress, prompt: Text("Adress").foregroundColor(Color.secondary)).frame(height: 40)
                    TextField("", text: $viewModel.profile.numberHome, prompt: Text("Home").foregroundColor(Color.secondary)).frame(height: 40)
                    
                }.textInputAutocapitalization(.characters)
                
                Section("Sign out") {
                    Button(action: {
                        viewModel.setProfile()
                        NotificationController.sharet.notify(title: "Save Profile",
                                                             subTitle: "You have saved your new user data!🧔‍♂️", timeInterval: 3)
                    }, label: {
                        HStack {
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                                .foregroundStyle(Color.green)
                            
                            Text("Save Profile")
                                .foregroundStyle(Color.white)
                        }
                    })
                    
                    Button(action: {
                        try? Auth.auth().signOut()
                        
                        isOut.toggle()
                        
                    }, label: {
                        HStack {
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                                .foregroundStyle(Color.red)
                            Text("Sign out")
                                .foregroundStyle(Color.white)
                        }
                        
                        
                    }).fullScreenCover(isPresented: $isOut, content: {
                        LoginSignInViewController()
                        
                    })
                }
            }
            .onAppear {
                self.viewModel.getProfile()
              
            }
        }
    }
}
@available(iOS 16.0, *)
#Preview {
    ProfileUserViewController(viewModel: ProfileViewModel(profile: MwUser(id: "", fullName: "", phone: "", adress: "", city: "", numberHome: "")))
}
