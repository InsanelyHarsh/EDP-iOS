//
//  Constants.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation
import CoreBluetooth

struct Constants{
    static var isBoardingCompletedKey:String = "IS_ONBOARDING_COMPLETED_USERDEFAULT_KEY"
    
    
    //Send by Student & scanned by Teacher..
    static var SERVICE_UUID:CBUUID = CBUUID(string: "759aabaf-1ffa-4e7b-b511-1dd267e066b3")
    static var CHAR_UUID = CBUUID(string: "e6e0f9c1-b753-4266-88d5-8423c571de17")
}
