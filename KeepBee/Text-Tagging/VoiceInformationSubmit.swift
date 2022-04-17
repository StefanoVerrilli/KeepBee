//
//  VoiceInformationSubmit.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 15/04/22.
//

import Foundation

func SubmitChanges(StringToSubmit: String,HivesArray: ObservableList){
    let ResultOfTagging = Tagger(stringToCheck: StringToSubmit,HivesArray: HivesArray)
    if ResultOfTagging != nil{
        let HiveSaved = ReloadHive(keyToChange: ResultOfTagging!.id.uuidString, newHive: ResultOfTagging!)
        ReloadNewArray(hiveToAppend: HiveSaved, GlobalHivesArray: HivesArray)
    }
}