//
//  ScanningServiceProgressDescription.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import Foundation
enum ScanningServiceProgressDescription:String{
    case idle = "Idle State"
    case scanningStarted = "Scanning has been Started 🚀"
    case scanningStopped = "Scanning has been Stopped."
    
    case connectionMadeWithTeacherDevice = "Connection has been Made 🤝"
    case connectingWithTeacherDevice = "Connecting 🔗"
    
    case didconnectingWithTeacherDevice = "Disconnecting ✂️"
    case didconnectedToTeacherDevice = "Disconnected with Student Device."
    
    case readingStudentCredentails = "Checking Credentials of Student. 🔬"
    case validCrentails = "Valid Credentails 👌🏼"
    
    case sendingConfirmationToStudent = "Sending Confirmation to Student. 📦"
    case confirmationSend = "Confirmation Send 🚚"
    
    case markedAttendance = "Marked Has been Marked ♾️"
    
    case bleStateUpdated = "Bluetooth State has been Updated 👶🏼"
}




enum ScanningServiceErrorDescription:String, Error{
    case bluetoothIsTurnedOff = "Turn on Bluetooth."
    case broadcastingError = "Error Occured while Broadcasting, Please try Again. ⚠️"
    
    case failedToConnect = "Error Occured while Connecting."
    case disconnectionError = "Diconnection Error"
    
    case decodingError = "Decoding Failed"
    case encodingError = "Encoding Failed while Sending Confirmation"
    
    case invalidCredentails = "Invalid Credentails"
}
