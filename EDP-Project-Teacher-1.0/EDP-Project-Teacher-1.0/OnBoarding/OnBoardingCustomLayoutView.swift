//
//  OnBoardingCustomLayoutView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct OnBoardingCustomLayoutView: View {
    let data:OnBoardingItem
    var body: some View {
        VStack{
            Text("\(data.title)")
                .font(.title)
            
            
            Text(data.emoji)
                .font(.system(size: 90))
            
            Text("\(data.content)")
                .padding()
            
            Spacer()
        }
        .padding(.top,50)
        .multilineTextAlignment(.center)
    }
}

struct OnBoardingCustomLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingCustomLayoutView(data: .init(emoji: "🤝", title: "Joint The Team", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut")
        )
    }
}
