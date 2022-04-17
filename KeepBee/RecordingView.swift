//
//  RecordingView.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 09/04/22.
//

import Foundation
import SwiftUI
import Speech

struct RecordingView: View{
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @ObservedObject var hivesArray: ObservableList
    var body:some View{
             VStack(spacing:100){
                 VStack{
                     HStack{
                     Text("Track your hives")
                         .font(.system(size: 32, weight: .bold))
                         .multilineTextAlignment(.leading)
                         .frame(alignment:.leading)
                         .foregroundColor(Color("CustomBlack"))
                         Spacer()
                     }
                  Text("Press the microphone or\nshake the phone to record")
                      .multilineTextAlignment(.leading)
                      .frame(maxWidth:.infinity,alignment: .leading)
                      .font(.system(size:26))
                      .foregroundColor(Color("CustomBlack"))
                 }.padding(.leading).padding(.top)
                 HStack{
                     swiftUISpeech.getButton()
                 }.padding(.vertical)
                 Spacer()
             }.background(BackgroundView())
    }
}




