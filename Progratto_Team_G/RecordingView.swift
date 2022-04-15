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
    @ObservedObject var HivesArray: HiveList
    var body:some View{
             VStack(spacing:100){
                 VStack{
                     HStack{
                     Text("Track your hives")
                         .font(.system(size: 32, weight: .bold))
                         .multilineTextAlignment(.leading)
                         .frame(alignment:.leading)
                         Spacer()
                     }
                  Text("Press the mic to record")
                      .multilineTextAlignment(.leading)
                      .frame(maxWidth:.infinity,alignment: .leading)
                      .font(.system(size:26))
                 }.padding(.leading).padding(.top)
                 HStack{
                     swiftUISpeech.getButton()
                 }.padding(.vertical)
                 HStack{
                     Text("\(swiftUISpeech.outputText)")// prints results to screen
                         .font(.title)
                         .bold()
                 }
                 Spacer()
             }.background(BackgroundView())
    }
}




