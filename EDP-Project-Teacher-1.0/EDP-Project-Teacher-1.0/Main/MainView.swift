//
//  MainView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 15/12/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var routeManger:RouteManager = RouteManager()
    @StateObject var tabManager:TabManager = TabManager()
    
    @State var showProfile:Bool = false
    @State var newCourse:Bool = false
    
    var body: some View {
        NavigationStack(path: $routeManger.route){
            TabView(selection: $tabManager.currentTab){
                //Home
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(TabRoutingViews.home)
                
                
                //Attendance
                MarkAttendanceView()
                    .tabItem {
                        Label("Attedance", systemImage: "dot.radiowaves.left.and.right")
                    }
                    .tag(TabRoutingViews.attendance)
                
                
                //Settings
                SettingView()
                    .environmentObject(tabManager)
                    .tabItem {
                        Label("Setting", systemImage: "gear")
                    }
                    .tag(TabRoutingViews.settings)
            }
            .environmentObject(routeManger)
            .navigationTitle(tabManager.currentTab.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .navigationAppearance(backgroundColor: .white, foregroundColor: .purple, tintColor: .systemBackground, hideSeparator: true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showProfile.toggle()
                    } label: {
                        Image(systemName: "person.circle.fill")
                    }
//                    .tint(.white)
                    .tint(.gray)
                }
                
//                if(self.tabManager.currentTab == .home){
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            withAnimation {
//                                self.newCourse.toggle()
//                            }
//                        } label: {
//                            Image(systemName: "plus")
//                        }.tint(.gray)
//                    }
//                }
            }
            .fullScreenCover(isPresented: $showProfile, content: {
                ProfileView()
            })
            .sheet(isPresented: $newCourse) {
                CreateNewCourseView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//import SwiftUI

struct NavAppearanceModifier: ViewModifier {
    init(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor?, hideSeparator: Bool) {
        let navItem = UINavigationItem()
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.backgroundColor = backgroundColor
//        if hideSeparator {
            navBarAppearance.shadowColor = .clear
//        }
        
        
        navItem.backButtonTitle = "EDP"
        navItem.backBarButtonItem = UIBarButtonItem(title: "Okayy", style: .done, target: nil, action: nil)
        
        navItem.backBarButtonItem = .init(title: "Blah")
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//        if let tintColor = tintColor {
//            UINavigationBar.appearance().tintColor = tintColor
//        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor? = nil, hideSeparator: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator))
        
    }
}
