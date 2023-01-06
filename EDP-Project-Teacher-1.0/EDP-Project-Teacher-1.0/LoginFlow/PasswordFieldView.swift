//
//  PasswordFieldView.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 05/01/23.
//

import SwiftUI

struct PasswordFieldView: View {
    
    @Binding var isSecured:Bool
    @Binding var password:String
    
    let title:String
    var body: some View {
        ZStack(alignment: .trailing){
            if(isSecured){
                SecureField(title, text: $password)
                    .textFieldStyle(.roundedBorder)
            }else{
                TextField(title, text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            
            Button {
                self.isSecured.toggle()
            } label: {
                Image(systemName: isSecured ? "eye.slash.fill" : "eye.fill")
            }
            .tint(.black)
            .padding(.trailing,5)
        }
        .animation(.none, value: self.isSecured)
    }
}

//struct PasswordFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordFieldView()
//    }
//}
