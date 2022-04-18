import Foundation

func SubmitChanges(StringToSubmit: String,HivesArray: ObservableList){
    let ResultOfTagging = Tagger(stringToCheck: StringToSubmit,HivesArray: HivesArray)
    if ResultOfTagging != nil{
        let HiveSaved = ReloadHive(keyToChange: ResultOfTagging!.id.uuidString, newHive: ResultOfTagging!)
        ReloadNewArray(hiveToAppend: HiveSaved, GlobalHivesArray: HivesArray)
    }
}
