//
//  OnBoardingManager.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation

///OnBoardingManager handles the OnBoardingViews Content
final class OnBoardingManager:ObservableObject{
    ///Array of OnBoarding Item shown on OnBoarding Views
    @Published private(set) var items:[OnBoardingItem] = []
    
    
    ///Function populate items with default Data
    func load(){
        self.items = [.init(emoji: "🚀", title: "Offline Attendance", content: "Revolutionary & Robust Attendance System"),
                      .init(emoji: "📈", title: "Track & Manage Attendance", content: "Simple way to Manage Attendance"),
                      .init(emoji: "⏳", title: "Save Time", content: "Be More Productive!")
        ]
    }
}
