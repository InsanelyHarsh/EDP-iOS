////
////  ProfileView.swift
////  EDP-Project-Teacher-1.0
////
////  Created by Harsh Yadav on 05/01/23.
////
//
//import SwiftUI

//
//  ProfileView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 17/12/22.
//

import SwiftUI

enum ProfileRoute{
    case edit
}
struct ProfileView: View {
    @StateObject var profileVM:ProfileViewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section {
                        LabeledContent("Name") {
                            Text("\(profileVM.teacherName)")
                        }
//                        LabeledContent("Name", value: profileVM.ss)
                        LabeledContent("Institute Email", value: profileVM.email)
                    } header: {
                        Text("Credentials")
                    }
                    
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.dismiss.callAsFunction()
                    } label: {
                        Text("Close")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("EDIT", value: ProfileRoute.edit)
                }
            }
            .navigationDestination(for: ProfileRoute.self) { value in
                if(value == .edit){
                    EditProfileView()
                        .environmentObject(profileVM)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack{
            ProfileView()
//        }.navigationTitle("Profile")
//            .navigationBarTitleDisplayMode(.inline)
    }
}
