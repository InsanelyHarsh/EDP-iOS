//
//  RootView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct RootView: View {
    @StateObject private var sessionManager:SessionManager = SessionManager()
    init(){
        let navItem = UINavigationItem()
        navItem.backButtonTitle = "EDP"
        
        let navApperenance = UINavigationBarAppearance()
        navApperenance.titleTextAttributes = [.foregroundColor: UIColor.blue]
        navApperenance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
    }
    var body: some View {
        ZStack{
            switch sessionManager.currentState{
            case .loggedIn:
                MainView()
                    .transition(.opacity)
                    .environmentObject(sessionManager)
            case .loggedOut:
                MainLoginView()
                    .transition(.opacity)
                    .environmentObject(sessionManager)
            case .onBoarding:
                OnBoardingView{
                    UserDefaults.standard.set(true, forKey: Constants.isBoardingCompletedKey)
                    self.sessionManager.signOut()
                }
                    .transition(.opacity)
                    .environmentObject(sessionManager)
            }
        }.onAppear{
            self.sessionManager.configureCurrentState()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
