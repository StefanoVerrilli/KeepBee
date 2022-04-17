//
//  SwiftUISpeech.swift
//  Progratto_Team_G
//
//  Created by Gianfranco on 12/04/22.
//

import Speech
import SwiftUI
import Foundation

public class SwiftUISpeech: ObservableObject{
        //Requests auth from User
    init(HivesKey : ObservableList){
        Hives = HivesKey
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                    case .authorized:
                        break

                    case .denied:
                        break
                    
                    case .restricted:
                        break
                      
                    case .notDetermined:
                        break
                      
                    default:
                        break
                }
            }
        }// end of auth request
        
        recognitionTask?.cancel()
        self.recognitionTask = nil

    }
    
    func getButton()->SpeechButton{ // returns the button
        return button
    }// end of get button
    
    func startRecording(){// starts the recording sequence
        
        // restarts the text
        outputText = "";
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        let inputNode = audioEngine.inputNode
        
        // try catch to start audio session
        do{
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }catch{
            print("ERROR: - Audio Session Failed!")
        }
        
        // Configure the microphone input and request auth
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
        }catch{
            print("ERROR: - Audio Engine failed to start")
        }
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Create a recognition task for the speech recognition session.
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ result, error in
            if (result != nil){
                self.outputText = (result?.transcriptions[0].formattedString)!
            }
            if let result = result{
                // Update the text view with the results.
                self.outputText = result.transcriptions[0].formattedString
            }
            if error != nil {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        }
    }// end of stop recording
    
    func stopRecording(){// end recording
        audioEngine.stop()
        recognitionRequest?.endAudio()
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        print(outputText)
        SubmitChanges(StringToSubmit: outputText,HivesArray: Hives)
    }// restarts the variables
    
    
    func getSpeechStatus()->String{// gets the status of authorization
        
        switch authStat{
            
            case .authorized:
                return "Authorized"
            
            case .notDetermined:
                return "Not yet Determined"
            
            case .denied:
                return "Denied - Close the App"
            
            case .restricted:
                return "Restricted - Close the App"
            
            default:
                return "ERROR: No Status Defined"
    
        }// end of switch
        
    }// end of get speech status
    
    /* Variables **/
    @Published var isRecording:Bool = false
    @ObservedObject var Hives: ObservableList
    @Published var button = SpeechButton(Hives: ObservableList())
    
    //private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "it-IT"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let authStat = SFSpeechRecognizer.authorizationStatus()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    public var outputText:String = "";
        
}
