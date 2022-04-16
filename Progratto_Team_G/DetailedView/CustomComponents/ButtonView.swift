//
//  ButtonView.swift
//  Progratto_Team_G
//
//  Created by Gianfranco on 12/04/22.
//

import Speech
import SwiftUI
import Foundation

struct SpeechButton: View {
    init(Hives : HiveList){
        HivesArray = Hives}
    @State var isPressed:Bool = false
    @State var actionPop:Bool = false
    @State var OnScreen: Bool = true
    @ObservedObject var HivesArray: HiveList = HiveList()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    var body: some View {
        Button(action:{// Button
            if(self.swiftUISpeech.getSpeechStatus() == "Denied - Close the App"){// checks status of auth if no auth pop up error
                self.actionPop.toggle()
            }else{
                withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){self.swiftUISpeech.isRecording.toggle()}// button animation
                self.swiftUISpeech.isRecording ? self.swiftUISpeech.startRecording() : self.swiftUISpeech.stopRecording()
            }
        }){
            ZStack{
                   Image(systemName:"circle.fill")
                    .font(.system(size:220)).foregroundColor(Color(UIColor(red: 237/255, green: 194/255, blue: 93/255, alpha: 1))).shadow(color: .black, radius: 4, x: 0, y: 0)
           
                Image(systemName:"mic.fill")
                    .font(.system(size:110)).foregroundColor(Color.white).shadow(color: .black, radius: 0, x: 0, y: 0)
            }
        }.actionSheet(isPresented: $actionPop){
            ActionSheet(title: Text("ERROR: - 1"), message: Text("Access Denied by User"), buttons: [ActionSheet.Button.destructive(Text("Reinstall the Appp"))])// Error catch if the auth failed or denied
        }.onShake {
            if OnScreen{
                withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){self.swiftUISpeech.isRecording.toggle()}
                self.swiftUISpeech.isRecording ? self.swiftUISpeech.startRecording() : self.swiftUISpeech.stopRecording()}
        }.onAppear(perform: {OnScreen = true}).onDisappear{OnScreen = false}
    }
}
