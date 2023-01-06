//
//  CreateNewCourseView.swift
//  EDP-Project-Teacher-1.0
//
//  Created by Harsh Yadav on 23/12/22.
//

import SwiftUI

struct CreateNewCourseView: View {
    @StateObject var createNewCourseVM:CreateNewCourseViewModel = CreateNewCourseViewModel()
    @EnvironmentObject var tabManager:TabManager
    @EnvironmentObject var routeManager:RouteManager
    var body: some View {
        VStack(spacing: 15){
            TextField("Course Name", text: $createNewCourseVM.courseName)
                .textFieldStyle(.roundedBorder)
            
            TextField("Course Code", text: $createNewCourseVM.courseCode)
                .textFieldStyle(.roundedBorder)
            
            TextField("Year", text: $createNewCourseVM.courseYear)
                .textFieldStyle(.roundedBorder)
            
            TextField("Semester", text: $createNewCourseVM.courseSemester)
                .textFieldStyle(.roundedBorder)
            
            TextField("Credits", text: $createNewCourseVM.courseCredit)
                .textFieldStyle(.roundedBorder)
            
                
            TextEditor(text: $createNewCourseVM.courseDescription)
                .border(.gray, width: 2.8)
                .cornerRadius(5)
                .disableAutocorrection(true)
                .frame(height: 150, alignment: .center)
            
            Button {
                
                //TODO: Create New Course
                //TODO: Send Invitation
                //TODO: Save to DB
                //TODO: Show on Home Page
                
                self.routeManager.goBack()
                self.tabManager.currentTab = .home
            } label: {
                Text("Create Course")
            }.buttonStyle(.borderedProminent)
                .tint(.purple)

            Spacer()
        }.padding()
        .navigationTitle("New Course")
    }
}

struct CreateNewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewCourseView()
    }
}
