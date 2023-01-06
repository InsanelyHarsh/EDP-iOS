//
//  LoginView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginVM:LoginViewModel = LoginViewModel()
    @EnvironmentObject var loginFlowRouter:LoginFlowRouteManager
    @State var isSecured:Bool = true
    
    let action:()->Void
    var body: some View {
        VStack(spacing: 40){
            
            VStack(spacing: 10){
                TextField("Enter your Email", text: $loginVM.email)
                    .textFieldStyle(.roundedBorder)
                
                PasswordFieldView(isSecured: $isSecured, password: $loginVM.password, title: "Enter Password")
            }
            HStack{
                Spacer()

                Button {
                    self.loginFlowRouter.navigationTo(.forgotPassword)
                } label: {
                    Text("Forgot Password?")
                        .underline()
                        .font(.subheadline)
                }.padding(.trailing,5)
            }
            .padding(.top,-20)
            
            Button {
                self.loginVM.login()
                if(self.loginVM.isValidCredentials){
                    self.action()
                }
            } label: {
                Text("Login")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .bold()
            
            
            Spacer()
        }.padding()
        .navigationTitle("Login")
        .alert(self.loginVM.alert.alertTitle, isPresented: $loginVM.showAlert) {
            //Action..
        } message: {
           Text(self.loginVM.alert.alertMsg)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginView{ }
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(LoginFlowRouteManager())
        }
    }
}
