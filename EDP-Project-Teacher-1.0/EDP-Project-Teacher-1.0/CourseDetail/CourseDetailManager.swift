//
//  CourseDetailManager.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 15/12/22.
//

import Foundation


class CourseDetailManager:ObservableObject{
    @Published private(set) var registeredCourses:[CourseDetailModel] = []
    
    
    func addNewCourse(_ course:CourseDetailModel){
        
    }
    
    func getCourseList(){
        //Dummy Data for now, actual Networking Call or fetch from DB
        
        self.registeredCourses = [
            .init(studentEnrolled: 122, department: .ece, courseName: "VLSI", courseCode: "EC3009", semester: "5", year: "2022"),
            .init(studentEnrolled: 60, department: .open, courseName: "Software Defined Networking", courseCode: "OE304", semester: "5", year: "2022"),
            .init(studentEnrolled: 256, department: .ece, courseName: "Electromagnetic Theory", courseCode: "EC3010", semester: "5", year: "2022"),
            .init(studentEnrolled: 20, department: .ece, courseName: "IT Workship", courseCode: "IT3001", semester: "5", year: "2022"),
            .init(studentEnrolled: 0, department: .ece, courseName: "Digital Communication", courseCode: "EC3011", semester: "5", year: "2022")
        ]
    }
    
    
}
