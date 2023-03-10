//
//  ScanningServiceProgressDescription.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import Foundation
enum ScanningServiceProgressDescription:String{
    case idle = "Idle State"
    case scanningStarted = "Scanning has been Started π"
    case scanningStopped = "Scanning has been Stopped."
    
    case connectionMadeWithTeacherDevice = "Connection has been Made π€"
    case connectingWithTeacherDevice = "Connecting π"
    
    case didconnectingWithTeacherDevice = "Disconnecting βοΈ"
    case didconnectedToTeacherDevice = "Disconnected with Student Device."
    
    case readingStudentCredentails = "Checking Credentials of Student. π¬"
    case validCrentails = "Valid Credentails ππΌ"
    
    case sendingConfirmationToStudent = "Sending Confirmation to Student. π¦"
    case confirmationSend = "Confirmation Send π"
    
    case markedAttendance = "Marked Has been Marked βΎοΈ"
    
    case bleStateUpdated = "Bluetooth State has been Updated πΆπΌ"
}




enum ScanningServiceErrorDescription:String, Error{
    case bluetoothIsTurnedOff = "Turn on Bluetooth."
    case broadcastingError = "Error Occured while Broadcasting, Please try Again. β οΈ"
    
    case failedToConnect = "Error Occured while Connecting."
    case disconnectionError = "Diconnection Error"
    
    case decodingError = "Decoding Failed"
    case encodingError = "Encoding Failed while Sending Confirmation"
    
    case invalidCredentails = "Invalid Credentails"
}
