//
//  AttendanceDetailViewModel.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import Foundation
import CoreBluetooth

enum AttendanceDetailAlertError:String{
    case none = ""
    case broadcastingError = "Error Occured While Broadcasting"
    case stopBroadcasting = "Do you want to Stop Broadcasting?"
    case generatePIN = "Please Generate PIN"
}





class AttendanceDetailViewModel:ObservableObject{
    let scanningService:ScanningService = ScanningService()
    
    @Published var isScanning:Bool = false
    @Published var isReadyForAttendance = false
    
    @Published var showAlert:Bool = false
    @Published var alertMessage:String = "Default Alert Message"
    
    @Published var progressDescription:String = "Idle"
    @Published var currentBluetoothStateDescription:String = "Fetching.."
    
    @Published var attendancePIN:String = "####"
    @Published var isPINGenerated:Bool = false
    
    init(){
        self.scanningService.delegate = self
        self.updateProgress()
        getCurrentBluetoothState()
    }
    
    //TODO: After marking attendance mark true and look for other students.
    //TODO: If all Student's Attendance has been marked stop Attendance after x time.
    func startScanning(){ //TODO: Scanning should be according to particular course. Currently Testing...
        if(isPINGenerated){
            self.scanningService.startScanning(withServices: [Constants.SERVICE_UUID]) //TODO: Get services from DB
        }else{
            self.showAlert(.generatePIN)
        }
    }
    
    func stopScanning(){
        self.scanningService.stopScanning()
    }
    
    func getRandomGeneratedPIN(){
        self.attendancePIN = "\(self.randomPINGenerator())"
        self.isPINGenerated = true
    }
}









extension AttendanceDetailViewModel:ScanningServiceDelegate{
    func didReviceStudentCredentails(_ credentails: ScannedDataModel) {
        if(credentails.pin == self.attendancePIN){
            
            self.progressDescription = ScanningServiceProgressDescription.validCrentails.rawValue
            
            self.scanningService.sendConfirmation(information: BroadcastedServiceDataModel(validPIN: true, markedAttendance: true),
                                                  for: self.scanningService.charatertistics!)
        }else{
            self.progressDescription = "Wrong PIN" //TODO: Look for next Student, store this state....
            self.scanningService.sendConfirmation(information: BroadcastedServiceDataModel(validPIN: false, markedAttendance: false),
                                                  for: self.scanningService.charatertistics!)
        }
    }
    
    func scanningServiceDelegateDidStartScanning() {
        self.isScanning = true
    }
    
    func scanningServiceDelegateDidStopScanning() {
        self.isScanning = false
    }
    
    func scanningServiceDelegateDidEstablishConnectionWithStudent(_ studentDevice: CBPeripheral) {
        //
    }
    
    func scanningServiceDelegateDidDisconnected() {
        //
    }
}











extension AttendanceDetailViewModel{
    //Progress Decription for User
    private func updateProgress(){
        self.scanningService.progressDescription = { [weak self] progress in
            switch progress{
            case .success(let success):
                self?.progressDescription = success.rawValue
            case .failure(let error):
                self?.alertMessage = error.rawValue
                self?.showAlert = true
            }
        }
    }
    
    //Bluetooth State Description for User
    private func getCurrentBluetoothState(){
        self.scanningService.bluetoothCurrentState = { [weak self] stateValue in
            if(stateValue == 5){
                self?.isReadyForAttendance = true
            }else{
                self?.isReadyForAttendance = false
            }
            
            self?.getDescriptionOf(state: stateValue) //State Description
        }
    }
    
    
    private func getDescriptionOf(state:Int){
        if(state == 0){
            self.currentBluetoothStateDescription = "Unknown State ❌"
        }
        else if(state == 1){
            self.currentBluetoothStateDescription = "Resetting ❌"
        }
        else if(state == 2){
            self.currentBluetoothStateDescription = "Unsupported ❌"
        }
        else if(state == 3){
            self.currentBluetoothStateDescription = "UnAuthorized ❌"
        }
        else if(state == 4){
            self.currentBluetoothStateDescription = "Powered Off ❌"
        }else if(state == 5){
            self.currentBluetoothStateDescription = "Powered On ✅"
        }
    }
    
    
    private func randomPINGenerator()->Int{
        return (1000...9999).randomElement() ?? 6969
    }
    
    private func showAlert(_ alertType:AttendanceDetailAlertError){
        self.alertMessage = alertType.rawValue
        self.showAlert = true
    }
}
