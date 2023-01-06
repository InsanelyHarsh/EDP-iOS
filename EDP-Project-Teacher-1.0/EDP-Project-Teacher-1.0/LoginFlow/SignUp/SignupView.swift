//
//  SignupView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var signupVM:SignupViewModel = SignupViewModel()
    @EnvironmentObject var loginFlowRouter:LoginFlowRouteManager
    let action:()->Void
    
    @State var isSecured:Bool = true
    @State var isConfirmSecured:Bool = true
    
    init(action: @escaping () -> Void) {
        self.action = action
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(spacing: 40){
            
            VStack(spacing: 15){
                VStack{
                    TextField("Name", text: $signupVM.name)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Email", text: $signupVM.email)
                        .textFieldStyle(.roundedBorder)
                }
                
                
                VStack{
//                    TextField("Department", text: $signupVM.description)
//                        .textFieldStyle(.roundedBorder)
                    
                    
                    TextField(
                        "free_form",
                        text: $signupVM.description,
                        prompt: Text("Description (Optional)"),
                        axis: .vertical
                    )
//                    .lineSpacing(10.0)
                    .lineLimit(7...)
                    .padding(16)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    
                }
                
                
                VStack(spacing: 10){
                    PasswordFieldView(isSecured: $isSecured, password: $signupVM.password, title: "Password")
                    
                    PasswordFieldView(isSecured: $isConfirmSecured, password: $signupVM.confirmPassword, title: "Confirm")
                }
                
                
            }

            
            Button {
                    self.action()
                //TODO: ....
//                self.signupVM.createAccount()
            } label: {
                Text("Create New Account")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .bold()
            
            
            Spacer()
        }.padding()
        .navigationTitle("Greatness is Comming")
        .alert(self.signupVM.alert.alertTitle, isPresented: $signupVM.showAlert) {
            //Action..
        } message: {
           Text(self.signupVM.alert.alertMsg)
        }

    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignupView{ }
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(LoginFlowRouteManager())
        }
    }
}
