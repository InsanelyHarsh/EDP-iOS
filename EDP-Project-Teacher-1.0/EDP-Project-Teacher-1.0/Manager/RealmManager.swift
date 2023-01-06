//
//  RealmManager.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 25/12/22.
//

/*
 import Foundation
 import RealmSwift

 enum RealmManagerError:Error{
     case realmFailed
     case fetchingFailed
 }
 final class RealmManager{
     static let shared:RealmManager = RealmManager()
     var realm:Realm?
     init(){
         setup()
     }
     
     func setup(){
         do{
             self.realm = try Realm()
         }catch{
             print("Error while opening Realm DB.",error)
         }
     }
     
     func initializeSchema(with name:String){
         let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! //Default Directory of Realm DB
         let realmFileUrl = docDir.appendingPathComponent("\(name).realm") //Giving Custom Name to Realm File
     }
     
     func configureRealm() {
         let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
             if oldSchemaVersion < 1 {
                 //TODO: migration if there any
             }
         }
         Realm.Configuration.defaultConfiguration = config
         do {
             realm = try Realm()
         } catch {
             print("Error opening default realm", error)
         }
         
     }
 }




 extension RealmManager{
     ///Returns Frozen Object
     ///Un-Freeze/ Thaw before changing it.
     func fetch<T:Object>(_ oject:T)throws -> [T]{
         guard let realm = realm else {
             throw RealmManagerError.realmFailed
         }
         
         return realm.objects(T.self).map{ $0.freeze() }
     }
 }
 */
