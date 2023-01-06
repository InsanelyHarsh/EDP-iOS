//
//  OnBoardingView.swift
//  EDP-Project-1.0
//
//  Created by Harsh Yadav on 14/12/22.
//

import SwiftUI

struct OnBoardingView: View {
    @StateObject private var onBoardingManager:OnBoardingManager = OnBoardingManager()
    @EnvironmentObject var sessionManager:SessionManager
    let action:()->Void
    var body: some View {
//        NavigationStack{
            VStack{
                if(onBoardingManager.items.count>0){
                    TabView {
                        ForEach(onBoardingManager.items) { item in
                            OnBoardingCustomLayoutView(data: item)
                                .overlay(alignment: .bottom){
                                    if(self.onBoardingManager.items.last! == item){
                                        Button {
//                                            self.sessionManager.onBoardingCompleted()
                                            action()
                                        } label: {
                                            Text("Continue")
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .padding(.bottom,50)
                                    }
                                }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    
                    Spacer()
                }
                
            }
//            .navigationTitle("On Boarding")
                .onAppear{
                    self.onBoardingManager.load()
                }
//        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView{ }
            .environmentObject(SessionManager())
    }
}
