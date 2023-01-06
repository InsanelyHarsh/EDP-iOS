//
//  CourseDetailModel.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 15/12/22.
//

import Foundation

enum Department:String{
    case ece = "Electronics & Communication "
    case cse = "Computer Science"
    case me = "Mechanical"
    case sm = "Smart Manufacturing"
    case design = "Design"
    case open = "All"
}


struct CourseDetailModel:Identifiable,Hashable{
    let id = UUID()
    
    let studentEnrolled:Int
    let department:Department
    
    let courseName:String
    let courseCode:String
    
//    let courseDescription:String
//    let courseCredit:String
    
    let semester:String
    let year:String
}

/*
 Teacher - s,s,s,s,s
 
 Student - c,c,c,c
 
 Course - s,s,s,s,s
 
 Attendance - s
 
 @Published var courseName:String = ""
 @Published var courseCode:String = ""

 @Published var courseDescription:String = "" //Optional
 @Published var courseCredit:String = ""

 @Published var courseYear:String = ""
 @Published var courseSemester:String = ""
 */
