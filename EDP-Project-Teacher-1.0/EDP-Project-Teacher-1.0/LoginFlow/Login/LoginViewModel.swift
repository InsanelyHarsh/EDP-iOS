//
//  LoginViewModel.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation


class LoginViewModel:ObservableObject{
    @Published var email:String = "harshmyadav2002@gmail.com"
    @Published var password:String = "12345678"
    
    @Published var isValidCredentials:Bool = false
    
    @Published var showAlert:Bool = false
    @Published var alert:LoginAlerts = .invalidEmail
    
    let authenticator = Authenticator.shared
    
    var validPass:Bool{
        get{
            return self.authenticator.isValidPassword(password: self.password)
        }
    }
    
    var validEmail:Bool{
        get{
            return self.authenticator.isValidEmail(self.email)
        }
    }
    
    func login(){
        if(self.validEmail && self.validPass){
            //TODO: Log Teacher In
            self.isValidCredentials = true
        }else{
            if(!self.validEmail){
                self.alert = .invalidEmail
                self.showAlert = true
            }else{
                self.alert = .invalidPassword
                self.showAlert = true
            }
        }
    }
}
