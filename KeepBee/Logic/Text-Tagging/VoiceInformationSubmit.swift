import Foundation

func SubmitChanges(StringToSubmit: String,HivesArray: ObservableList){
    let ResultOfTagging = Tagger(stringToCheck: StringToSubmit,HivesArray: HivesArray)
    if ResultOfTagging != nil{
        let HiveSaved = ReloadFiles(keyToChange: ResultOfTagging!.id.uuidString, newHive: ResultOfTagging!)
        ReloadFilesArray(hiveToAppend: HiveSaved, GlobalHivesArray: HivesArray)
    }
}
