//
//  SessionManager.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation
import SwiftUI
///Session Manager controls the Weather user is Logged in/out along with OnBoarding View
final class SessionManager:ObservableObject{
    
    enum CurrentState{
        case loggedIn
        case loggedOut
        case onBoarding
    }
    
    @Published private(set) var currentState:CurrentState = .onBoarding
    
    
    func signIn(){
        withAnimation {
            self.currentState = .loggedIn
        }
    }
    
    func signOut(){
        withAnimation {
            self.currentState = .loggedOut
        }
    }
    
    func onBoardingCompleted(){
//        UserDefaults.standard.setValue(true, forKey: Constants.isBoardingCompletedKey)
        withAnimation {
            self.currentState = .loggedOut
        }
    }
    
    func configureCurrentState(){
        let hasSeenOnBording = UserDefaults.standard.bool(forKey: Constants.isBoardingCompletedKey)
//        let hasSeenOnBording = false
        currentState  = hasSeenOnBording ? .loggedOut : .onBoarding
    }
}
