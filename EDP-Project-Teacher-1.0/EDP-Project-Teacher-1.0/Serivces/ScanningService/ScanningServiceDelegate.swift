//
//  ScanningServiceDelegate.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import Foundation
import CoreBluetooth

protocol ScanningServiceDelegate{
    func scanningServiceDelegateDidStartScanning()
    func scanningServiceDelegateDidStopScanning()
    
    func scanningServiceDelegateDidEstablishConnectionWithStudent(_ studentDevice:CBPeripheral)
    func scanningServiceDelegateDidDisconnected()
    
    func didReviceStudentCredentails(_ credentails:ScannedDataModel)
//    func didSendConfirmation()
}
