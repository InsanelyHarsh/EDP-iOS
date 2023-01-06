//
//  AttendanceDetailView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 19/12/22.
//

import SwiftUI

struct AttendanceDetailView: View {
    @StateObject var attendanceDetailVM:AttendanceDetailViewModel = AttendanceDetailViewModel()
    var body: some View {
        VStack{
            
            List{
                LabeledContent("State") {
                    Text("\(self.attendanceDetailVM.currentBluetoothStateDescription)")
                }
                LabeledContent("Progress") {
                    Text("\(self.attendanceDetailVM.progressDescription)")
                }
                LabeledContent("PIN") {
                    Text(self.attendanceDetailVM.attendancePIN)
                }
            }
            .listStyle(.plain)
            .frame(height: 120)
            
            
            HStack{
                Text(self.attendanceDetailVM.attendancePIN)
                
                Button {
                    self.attendanceDetailVM.getRandomGeneratedPIN()
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                }
                .disabled(self.attendanceDetailVM.isScanning)

            }
            .font(.title)
            .bold()
            .padding()
            Spacer()
            
            
            HStack{
                Button {
                    self.attendanceDetailVM.startScanning()
                } label: {
                    Text("Start Attendance")
                }.buttonStyle(.borderedProminent)
                    .disabled(self.attendanceDetailVM.isScanning)
                
                Button {
                    self.attendanceDetailVM.stopScanning()
                } label: {
                    Text("Stop Attendance")
                }.buttonStyle(.bordered)
                    .disabled(!self.attendanceDetailVM.isScanning)
            }
            .font(.title3)
            .padding(.bottom,20)
        }
        .navigationTitle("Take Attendance")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert(self.attendanceDetailVM.alertMessage, isPresented: $attendanceDetailVM.showAlert) {
            
        }
    }
}

struct AttendanceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AttendanceDetailView()
        }
    }
}
