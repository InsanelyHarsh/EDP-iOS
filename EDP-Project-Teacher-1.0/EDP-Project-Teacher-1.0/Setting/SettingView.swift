//
//  SettingView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 15/12/22.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var routeManager:RouteManager
    @EnvironmentObject var sessionManager:SessionManager
    @EnvironmentObject var tabManager:TabManager
    
    @Environment(\.colorScheme) var colorScheme
    @State var changeToDarkColorScheme:Bool = false
    @State var showAlert:Bool = false
    var body: some View {
        VStack{
            Form {
                Section {
                    NavigationLink(value: SettingRouteViews.createNewCourse) {
                        Text("Create New Course")
                    }
                    LabeledContent("Appereance", value: self.changeToDarkColorScheme ? "Dark" : "Light")
                        .onTapGesture {
                            self.changeToDarkColorScheme.toggle()
                        }
                    LabeledContent("Notifications", value: "Default")
                }
                
                Section{
                    Text("About Us")
                    Text("Terms of Service")
                    Text("Privacy Policy")
                }
                
                Section{
                    Button {
                        self.showAlert.toggle()
                    } label: {
                        Text("Log Out")
                    }.tint(.red)
                }
            }
            .navigationDestination(for: SettingRouteViews.self, destination: { value in
                if(value == .createNewCourse){
                    CreateNewCourseView()
                        .environmentObject(tabManager)
                        .environmentObject(routeManager)
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Log Out"),
                      message: Text("Do you want to Log out?"),
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("Yes"), action: {
                    withAnimation {
                        UserDefaults.standard.set(false, forKey: Constants.isBoardingCompletedKey)
                        self.sessionManager.configureCurrentState()
                    }
                }))
            }
        }
//        .environment(\.colorScheme, self.changeToDarkColorScheme ? .dark : .light)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingView()
        }
    }
}
