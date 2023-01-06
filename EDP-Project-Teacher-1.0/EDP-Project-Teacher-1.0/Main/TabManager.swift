//
//  TabManager.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 17/12/22.
//

import Foundation


enum TabRoutingViews:String, Hashable{
    case home = "Home"
    case attendance = "Attendance"
    case settings = "Settings"
}

///Handles Tab of Application
class TabManager:ObservableObject{
    @Published var currentTab:TabRoutingViews = .home
    
    func changeTab(to newTab:TabRoutingViews){
        self.currentTab = newTab
    }
}
