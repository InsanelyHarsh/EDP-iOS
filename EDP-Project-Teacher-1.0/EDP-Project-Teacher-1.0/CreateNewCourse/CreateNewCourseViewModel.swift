//
//  CreateNewCourseViewModel.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
enum CreateNewCourseAlertMessage{
    case invalidEmail
}

class CreateNewCourseViewModel:ObservableObject{
    
    let authenticator:Authenticator = Authenticator.shared
    
    @Published var showAlert:Bool = false
    @Published var alertMessage:String = ""
    
    @Published var courseName:String = ""
    @Published var courseCode:String = ""
    
    @Published var courseDescription:String = "" //Optional
    @Published var courseCredit:String = ""
    
    @Published var courseYear:String = ""
    @Published var courseSemester:String = ""
    
    //        @Published var serviceUUID:String = "" //TODO: Randomly Generated by Server and Stored Locally
    
    //    @Published var instructors:List<TeacherModel> //Basic Detail
    //    @Published var enrolledStudentData:List<StudentModel> //TODO: Extract from CSV file? / Enter Manually(Tedious)
    //    @Published var courseAttendance:List<ClassAttendanceModel>
}

extension CreateNewCourseViewModel{
    func verifyCredentails(){
        //TODO: Show Alert if Alert are not valid
    }
    
    func sendData(){
        //TODO: Send Data to Server and get Service UUID
    }
    
    func createNewCourse(){
        //TODO: Create Course,using Service Recieved by Server.
        //Show these courses on Home
    }
}
