//
//  HomeView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var courseManager:CourseDetailManager = CourseDetailManager()
    
    var body: some View {
        VStack{
            //MARK: Registered Courses
            if(courseManager.registeredCourses.isEmpty){
                Text("Start Building Future ✍🏼")
                Text("Click + to Create New Course")
            }else{
                Form{
                    Section {
                        ForEach(courseManager.registeredCourses, id: \.id) { course in
                            NavigationLink(value: course) {
                                Text("\(course.courseName)")
                            }
                        }
                    } header: {
                        Text("Your Courses")
                    } footer: {
                        Text("Click + to Create new Course")
                    }
                }
            }
        }
        .onAppear{
            self.courseManager.getCourseList() //Fetch Course List
        }
        .navigationDestination(for: CourseDetailModel.self, destination: { course in
            CourseDetailView(course: course)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RouteManager())
    }
}
