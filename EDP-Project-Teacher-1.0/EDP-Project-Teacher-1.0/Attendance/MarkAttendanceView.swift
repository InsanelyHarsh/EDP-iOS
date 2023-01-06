//
//  MarkAttendanceView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 15/12/22.
//

import SwiftUI

enum MarkAttendanceRoute{
    case attendanceDetail
}

struct MarkAttendanceView: View {
    @EnvironmentObject var routeManger:RouteManager
    var body: some View {
        VStack{
            List{
                LabeledContent("Bluetooth"){
                    Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                }
                
                LabeledContent("Location"){
                    Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                }
                
                LabeledContent("Camera"){
                    Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                }

            }.listStyle(.plain)
            

            Spacer()
            
            NavigationLink(value: MarkAttendanceRoute.attendanceDetail) {
                Text("Start Attentance")
            }
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
            .font(.title2)
            .padding(.bottom,20)

            
        }
        .navigationTitle("Mark Attendance")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        
        .navigationDestination(for: MarkAttendanceRoute.self) { value in
            if(value == .attendanceDetail){
                AttendanceDetailView()
            }
        }
    }
}

struct MarkAttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MarkAttendanceView()
        }
//        MainView()
    }
}
