//
//  EditProfileView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 24/12/22.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var profileVM:ProfileViewModel
    var body: some View {
        VStack{
            TextField("Name", text: $profileVM.teacherName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Insitute Email", text: $profileVM.email)
                .textFieldStyle(.roundedBorder)

            Button {
                //Save Credentials
            } label: {
                Text("Done")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }.padding()
            .navigationTitle("Edit Profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

