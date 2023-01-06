//
//  ForgotPasswordViewModel.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation
class ForgotPasswordViewModel:ObservableObject{
    @Published var registeredEmail:String = ""
    
    @Published var newPassword:String = ""
    @Published var newConfirmPassword:String = ""

    @Published var showAlert:Bool = false
    @Published var alert:LoginAlerts = .invalidEmail
    
    let authenticator = Authenticator.shared
    
    var isValidNewPassword:Bool{
        get{
            return self.authenticator.isValidPassword(password: self.newPassword, confirmPassword: self.newConfirmPassword)
        }
    }
    
    func updatePassword(){
        if(isValidNewPassword){
            //TODO: Make API Request
        }else{
            if(self.newPassword.count < 8){
                self.alert = .invalidPassword
                self.showAlert = true
            }else{
                self.alert = .mismatchPass
                self.showAlert = true
            }
//            self.showAlert = true
        }
    }
}
