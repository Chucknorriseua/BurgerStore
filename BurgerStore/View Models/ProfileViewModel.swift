//
//  ProfileViewModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 01/02/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {

    
    @Published var profile: MwUser
   
    init(profile: MwUser) {
        self.profile = profile

    }

    func setProfile() {
        DataBaseService.shared.setUser(user: self.profile) { result in
            switch result {
            case .success(let user):
                print(user.fullName)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile() {
        
        DataBaseService.shared.getProfile { result in
            switch result {
                
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
