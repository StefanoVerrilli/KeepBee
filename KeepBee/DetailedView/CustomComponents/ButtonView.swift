import Speech
import SwiftUI
import Foundation

struct SpeechButton: View {
    init(Hives : ObservableList){
        hivesArray = Hives}
    @State var isPressed:Bool = false
    @State var actionPop:Bool = false
    @State var onScreen: Bool = true
    @ObservedObject var hivesArray: ObservableList = ObservableList()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    
    var body: some View {
        Button(action:{// Button
            if(self.swiftUISpeech.getSpeechStatus() == "Denied - Close the App"){// checks status of auth if no auth pop up error
                self.actionPop.toggle()
            }else{
                withAnimation(.easeInOut){self.swiftUISpeech.isRecording.toggle()}
                self.swiftUISpeech.isRecording ? self.swiftUISpeech.startRecording() : self.swiftUISpeech.stopRecording()
            }
        }){
            ZStack{
                Image(systemName:"circle.fill")
                    .scaleEffect(self.swiftUISpeech.isRecording ? 1.1 : 1.0)
                    .font(.system(size:220)).foregroundColor(Color(UIColor(red: 237/255, green: 194/255, blue: 93/255, alpha: 1))).shadow(color: Color("CustomBlack"), radius: 4, x: 0, y: 0)
                    Image(systemName:"mic.fill")
                    .font(.system(size:110)).foregroundColor(self.swiftUISpeech.isRecording ? Color("CustomRed") : Color.white).shadow(color: .black, radius: 0, x: 0, y: 0)
            }
        }.actionSheet(isPresented: $actionPop){
            ActionSheet(title: Text("ERROR: - 1"), message: Text("Access Denied by User"), buttons: [ActionSheet.Button.destructive(Text("Reinstall the Appp"))])// Error catch if the auth failed or denied
        }.onShake {
            if(self.swiftUISpeech.getSpeechStatus() == "Denied - Close the App"){
                self.actionPop.toggle()
            }else{
                withAnimation(.easeInOut){self.swiftUISpeech.isRecording.toggle()}
                self.swiftUISpeech.isRecording ? self.swiftUISpeech.startRecording() : self.swiftUISpeech.stopRecording()
            }
        }.onAppear(perform: {onScreen = true}).onDisappear{onScreen = false}
    }
}
