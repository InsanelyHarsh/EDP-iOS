//
//  Branch.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
enum Branch:CaseIterable{
    case ece
    case cse
    case mech
    case sm
    case design
    
    
    var branchName:String{
        switch self {
        case .ece:
            return "ECE"
        case .cse:
            return "CSE"
        case .mech:
            return "ME"
        case .sm:
            return "SM"
        case .design:
            return "Design"
        }
    }
    
    var fullBranchName:String{
        switch self {
        case .ece:
            return "Electronics and Communication"
        case .cse:
            return "Computer Science"
        case .mech:
            return "Mechanical"
        case .sm:
            return "Smart Manufacturing"
        case .design:
            return "Design"
        }
    }
}
