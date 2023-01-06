//
//  MainLoginView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct MainLoginView: View {
    
    @StateObject var loginFlowRouter:LoginFlowRouteManager = LoginFlowRouteManager()
    @EnvironmentObject var sessionManager:SessionManager
    
    var body: some View {
        NavigationStack(path: $loginFlowRouter.loginFlowRoutingPath) {
            VStack(spacing: 90){
                
                Text("New & Robust Attendance System")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                VStack{
                    
                    Button {
                        self.loginFlowRouter.navigationTo(.login)
                    } label: {
                        Text("Continue your Great Journey")
                    }.buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .bold()
                    
                    CustomDivider()
                    
                    Button {
                        self.loginFlowRouter.navigationTo(.createNewAccount)
                    } label: {
                        Text("Start New Journey 🎉")
                    }.buttonStyle(.borderedProminent)
                        .tint(.cyan)
                        .bold()
                }

                
                Spacer()
            }
            .environmentObject(loginFlowRouter)
            .navigationDestination(for: LoginFlowState.self, destination: { state in
                switch state{
                case .login:
                    LoginView{                                      //TODO: Improve this functionality
                        self.loginFlowRouter.goToMainLoginView()
                        self.sessionManager.signIn()
                    }.environmentObject(loginFlowRouter)
                case .forgotPassword:
                    ForgotPasswordView{
                        withAnimation {
                            self.loginFlowRouter.goBack()
                        }
                    }
                case .createNewAccount:
                    SignupView{
                        self.loginFlowRouter.goToMainLoginView()
                        self.sessionManager.signIn()
                    }
                }
            })
            .navigationTitle("🚀")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoginView()
    }
}




///Custom Divider Between Login & Sign in Buttons
struct CustomDivider: View {
    var body: some View {
        HStack(spacing:5){
            Rectangle()
                .frame(width: 120, height: 1, alignment: .center)
            
            Text("Or")
                .font(.caption).foregroundColor(.secondary)
            
            Rectangle()
                .frame(width: 120, height: 1, alignment: .center)
        }
        .padding(.vertical,10)
    }
}
