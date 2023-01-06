//
//  ScanningService.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import Foundation
import CoreBluetooth

class ScanningService:NSObject{
    private var centralManager:CBCentralManager!
    private var discoveredDevicesList:Set<CBPeripheral> = []
    
    
    var delegate:ScanningServiceDelegate?
    var progressDescription:((Result<ScanningServiceProgressDescription,ScanningServiceErrorDescription>)->Void)?
    var bluetoothCurrentState:((Int)->Void)?
    
    //stores the service & characteristic of device for some time..
    var studentDevice:CBPeripheral? = nil
    var charatertistics:CBCharacteristic? = nil
    
    
    override init(){
        super.init()
        progressDescription?(.success(.idle))
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}



extension ScanningService{
    
    ///Start Scanning
    func startScanning(withServices: [CBUUID] = []){
        if(!self.centralManager.isScanning){
            
            //Scan only when in powered on state
            if(self.centralManager.state == .poweredOn){
                self.centralManager.scanForPeripherals(withServices: withServices)
                
                progressDescription?(.success(.scanningStarted))
                self.delegate?.scanningServiceDelegateDidStartScanning()
            }
            else{
                self.progressDescription?(.failure(.bluetoothIsTurnedOff))
            }
            
        }else{
            self.progressDescription?(.failure(.bluetoothIsTurnedOff)) //TODO: Change failure Message..
            self.delegate?.scanningServiceDelegateDidStopScanning()
        }
    }
    
    
    
    //Stop Scanning
    func stopScanning(){
        self.centralManager.stopScan()
        
        self.progressDescription?(.success(.scanningStopped))
        self.delegate?.scanningServiceDelegateDidStopScanning()
    }
    
    
    
    //Connect Device
    func connectWithDevice(device:CBPeripheral){
        self.progressDescription?(.success(.connectingWithTeacherDevice))
        
        self.centralManager.connect(device)
    }
    
    
    
    //Disconnect Device
    func disconnect(device:CBPeripheral){
        self.progressDescription?(.success(.didconnectingWithTeacherDevice))
        
        self.centralManager.cancelPeripheralConnection(device)
    }
}






extension ScanningService:CBCentralManagerDelegate{
    
//----------------------------------------------------------* STATE *---------------------------------------------------------------
    //Update State
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        Logger.logMessage("Updated Central State, new State: \(central.state)")
        self.bluetoothCurrentState?(central.state.rawValue)
    }
    
    
    //Will Restore State
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        Logger.logMessage("Central will Restore to \(central.state) State")
    }
}





extension ScanningService{
    
//----------------------------------------------------------* DICOVERY *---------------------------------------------------------------
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        guard RSSI.intValue >= -50 else {
                print("Discovered perhiperal not in expected range, at %d", RSSI.intValue)
                return
        }
        
//        self.discoveredDevicesList.insert(peripheral)
//        self.discoveredDevices(self.discoveredDevicesList.map{$0})
        self.studentDevice = peripheral
        self.studentDevice!.delegate = self
//        self.stopScanning()
        
        self.connectWithDevice(device: peripheral)
    }
    
    
    
    
//----------------------------------------------------------* CONNECTION *---------------------------------------------------------------
    
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.progressDescription?(.success(.connectionMadeWithTeacherDevice))
        
//        self.discoverStudentCredentials(for: peripheral) //Looking for Student Credentails..
        self.studentDevice!.discoverServices([Constants.SERVICE_UUID])
    }
    
    

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        self.progressDescription?(.failure(.failedToConnect))
        Logger.logError("Failed to Connect \(peripheral.identifier)")
    }
    
    

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if error == nil {
            self.progressDescription?(.success(.didconnectedToTeacherDevice))
            Logger.logMessage("Disconnected \(peripheral.identifier)")
        }else {
            self.progressDescription?(.failure(.disconnectionError))
            Logger.logError("Error While Diconnecting \(peripheral.identifier)")
        }
    }
}



















extension ScanningService{
    func sendConfirmation(information:BroadcastedServiceDataModel,for char:CBCharacteristic,type:CBCharacteristicWriteType = .withResponse){
        do{
            let responseData = try JSONEncoder().encode(information)
            
            self.studentDevice!.writeValue(responseData, for: char, type: type)
            
            self.progressDescription?(.success(.sendingConfirmationToStudent))
            Logger.logMessage("Writing Confirmation to Student!")
        }catch{
            Logger.logError("Encoding Failed while Sending Confirmation")
        }
    }
}





//MARK: Discover Services & Characteristics
extension ScanningService:CBPeripheralDelegate{
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {    //TODO: If no service found, move to next student device.
        guard let services = peripheral.services else { //Handling nil Services
            Logger.logError("No Services Found in \(peripheral)")
            return
        }

        for service in services {
            peripheral.discoverCharacteristics([Constants.CHAR_UUID], for: service) //Search Charactertics
        }
    }
    
    
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        Logger.logMessage("Looking for Characteristics 🔍")
        
        
        //TODO: Same as Service, if charactertics is not there, move to next student. Also, Store this info for which student these error occur.
        //Do Not Show Alert, as it would break automation.
        guard let characteristics = service.characteristics else { //Handling Error
            Logger.logError("No Characteristics Found in \(service)")
            return
        }
        
        for characteristic in characteristics{  //Reading Data from Characteristics
            self.charatertistics = characteristic
            peripheral.readValue(for: characteristic)
            
            if let scannedData = characteristic.value{
                
                do{
                    let scannedStduentDetail = try JSONDecoder().decode(ScannedDataModel.self, from: scannedData)
                    self.charatertistics = characteristic
                    self.delegate?.didReviceStudentCredentails(scannedStduentDetail)
                    
//                    self.sendConfirmation(information: "Spectre", for: characteristic) //Confirmation will be send after checking credentials.
                    Logger.logMessage("Student Recieved Data: \(scannedStduentDetail)")
                }catch{
                    Logger.logError("Decoding Failed for \(characteristic) Charactertistic.")
                }
                
            }else{
                Logger.logMessage("Nil Value Found!")
                self.studentDevice!.setNotifyValue(true, for: characteristic)
                self.charatertistics = characteristic
            }
        }
    }
}



//MARK: Values..
extension ScanningService{
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        Logger.logMessage("Updated value for \(characteristic.uuid)")
        
        guard let data = characteristic.value else{
            Logger.logMessage("Updated Data is Nil")
            return
        }
        
        do{
            let scannedStduentDetail = try JSONDecoder().decode(ScannedDataModel.self, from: data)
            self.delegate?.didReviceStudentCredentails(scannedStduentDetail)
            
            Logger.logMessage("Updated Value: \(scannedStduentDetail)")
            Logger.logLine()
//            self.sendConfirmation(information: "Phantom", for: characteristic) //Confirmation will be send after checking credentials.
        }catch{
            Logger.logMessage("Decoding Failed while looking for Updated Credentails of Student.")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        self.progressDescription?(.success(.confirmationSend))
        
        Logger.logMessage("Write Data on \(characteristic.uuid)")
//        self.disconnect(device: peripheral) //Move this Logic to VM
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        Logger.logMessage("Updated Notification State for \(characteristic) is \(characteristic.isNotifying)")
    }
}
