//
//  CourseDetailView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 15/12/22.
//

import SwiftUI
import Charts

struct CourseDetailView: View {
    let course:CourseDetailModel
    var body: some View {
        VStack{
//            Text(course.courseName)
            Form {
                Section("Couse Code \(course.courseCode)") {
                    List {
                        LabeledContent("Course", value: course.courseName)
                        LabeledContent("Department", value: course.department.rawValue)
                        LabeledContent("Student Enrolled", value: "\(course.studentEnrolled)")
                        LabeledContent("Semestor", value: course.semester)
                    }
                }
            }
            
            /*
             TODO: Charts
             - Number of Student Present Each Day ( Line Chart )
             - Student
             */
        }
        .navigationTitle(course.courseName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: .init(studentEnrolled: 60, department: .open, courseName: "Software Defined Networking", courseCode: "OE304", semester: "5", year: "2022"))
    }
}

struct CourseDetailItem: View {
    let heading:String
    let headingValue:String
    var body: some View {
        HStack{
            Text("\(heading)")
            Spacer()
            Text("\(headingValue)")
                .foregroundColor(.secondary)
        }
    }
}
