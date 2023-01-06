//
//  ProfileViewModel.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation

class ProfileViewModel:ObservableObject{
//    var realm = RealmManager.shared.realm
    
    @Published var teacherName:String = "Professor X"
    @Published var email:String = "20bec043@iiitdmj.ac.in"

    
    ///Fetch Student Profile Data from Database
    func fetchCredentials(){
        //fetch
    }
    
    func updateCredentails(){
        //update changes
    }
}
