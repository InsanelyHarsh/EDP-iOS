//
//  OnBoardingItem.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation

struct OnBoardingItem:Identifiable,Equatable{
    let id = UUID()
    let emoji:String
    let title:String
    let content:String
}
