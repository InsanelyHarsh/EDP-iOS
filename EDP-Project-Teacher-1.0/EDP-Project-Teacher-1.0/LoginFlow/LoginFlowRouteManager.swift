//
//  LoginFlowRouteManager.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation

enum LoginFlowState:Hashable{
    case login
    case createNewAccount
    case forgotPassword
}

///LoginFlowRouteManager handles routing of Views(Login,Create new Account & Forgot Password)
///Navigation between Login Flow Views
final class LoginFlowRouteManager:ObservableObject{
    @Published var loginFlowRoutingPath:[LoginFlowState] = []
    

    
    func goBack(){
        if(self.loginFlowRoutingPath.count>0){
            self.loginFlowRoutingPath.removeLast()
        }
    }
    
    func goToMainLoginView(){
        self.loginFlowRoutingPath = []
    }
    
    func navigationTo(_ state:LoginFlowState){
        self.loginFlowRoutingPath.append(state)
    }
    
//    @ViewBuilder
//    func goTo(_ state:LoginFlowState)->some View{
//        switch state{
//        case .login:
//            LoginView{
//
//            }
//        case .forgotPassword:
//            ForgotPasswordView()
//        case .createNewAccount:
//            SignupView()
//        }
//    }
    
    
}
