//
//  Logger.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import Foundation

struct Logger{
    
    static func logMessage(_ completion:@autoclosure (()->(String)) ){
        print("[LOG] \(completion()) \n")
    }
    
    static func logError(_ completion:@autoclosure (()->(String)) ){
        print("\n [ERROR] \(completion()) \n")
    }
    
    static func logLine(){
        print("\n------------------------------------\n")
    }
}
