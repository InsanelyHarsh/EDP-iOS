//
//  LoginAlerts.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 05/01/23.
//

import Foundation

enum LoginAlerts{
    case invalidEmail
    
    case invalidPassword
    case mismatchPass
    
    case userAlreadyExist
    
    var alertTitle:String{
        switch self {
        case .invalidEmail:
            return "Invalid Email"
        case .mismatchPass:
            return "Password Mismatch"
        case .userAlreadyExist:
            return "User Already Exist"
        case .invalidPassword:
            return "Invalid Password"
        }
    }
    
    var alertMsg:String{
        switch self {
        case .invalidEmail:
            return "Please Enter Valid Email Address"
        case .mismatchPass:
            return "Confirm Password does not match with Password"
        case .userAlreadyExist:
            return "Please Enter different Email or Login"
        case .invalidPassword:
            return "Password should be of atleast length 8"
        }
    }
}
