//
//  PeripheralService.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import Foundation
import CoreBluetooth


class PeripheralService:NSObject{
    var studentDevice:CBPeripheral

    var charatertistics:CBCharacteristic!
    
    var disconnectDevice:(()->Void)?
    init(studentDevice:CBPeripheral) {
        self.studentDevice = studentDevice
        super.init()
        
        self.studentDevice.delegate = self
    }
    
    
    
    ///Discover Services
    func lookFor(serviceUUID:[CBUUID]?){
        self.studentDevice.discoverServices(serviceUUID)    //Discover only services with these UUIDs
    }
    
    
    ///Write on Charactertic
    func sendConfirmation(information:String,type:CBCharacteristicWriteType = .withResponse){
        do{
            let responseData = try JSONEncoder().encode(information)
            self.studentDevice.writeValue(responseData, for: charatertistics, type: type)
            
        }catch{
            Logger.logError("Encoding Failed while Sending Confirmation")
        }
    }
    
    
    ///Send
    private func setNotification(on char:CBCharacteristic){
        self.studentDevice.setNotifyValue(true, for: char)
    }
}





//MARK: Discover Services & Characteristics
extension PeripheralService:CBPeripheralDelegate{
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { //Handling nil Services
            Logger.logError("No Services Found in \(peripheral)")
            return
        }

        for service in services {
            peripheral.discoverCharacteristics([Constants.CHAR_UUID], for: service) //Search Charactertics
        }
    }
    
    
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
//        Logger.logMessage("Looking for Characteristics 🔍")
        
        guard let characteristics = service.characteristics else { //Handling Error
            Logger.logError("No Characteristics Found in \(service)")
            return
        }
        
        for characteristic in characteristics{  //Reading Data from Characteristics
            self.charatertistics = characteristic
            peripheral.readValue(for: characteristic)
            
            if let scannedData = characteristic.value{
                
                do{
                    let scannedClassDetail = try JSONDecoder().decode(ScannedDataModel.self, from: scannedData)
                    Logger.logMessage("Student Recieved Data: \(scannedClassDetail)")
                    self.charatertistics = characteristic
                    self.sendConfirmation(information: "We Recieved!")
                    
                    self.disconnectDevice?()
                    
                }catch{
                    Logger.logError("Decoding Failed for \(characteristic) Charactertistic.")
                }
                
            }else{
                Logger.logMessage("Nil Value Found!")
                self.setNotification(on: characteristic)
                self.charatertistics = characteristic
            }
        }
    }
}



//MARK: Values..
extension PeripheralService{
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        Logger.logMessage("Updated value for \(characteristic.uuid)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        Logger.logMessage("Write Data on \(characteristic.uuid)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        Logger.logMessage("Updated Notification State for \(characteristic) is \(characteristic.isNotifying)")
    }
}
