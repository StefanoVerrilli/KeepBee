//
//  ParthenopeKitLoad.swift
//  KeepBee
//
//  Created by Stefano Verrilli on 18/04/22.
//

import Foundation
import ParthenoKit

var p: ParthenoKit = ParthenoKit()
let TeamKey = "TeamG2122S678CR"
let HivesKey = "HivesKey"

func SaveFiles(HiveToSave: Hive,KeyToInsert: String){
    if let jsonData = try? JSONEncoder().encode(HiveToSave){
        let jsonString = String(data: jsonData, encoding: .utf8)
        p.writeSync(team: TeamKey, tag: "", key: KeyToInsert, value: jsonString)
    }
    
}

func LoadFiles(keyToFind: String) -> Hive{
    if let HiveAsString = p.readSync(team: TeamKey, tag: "", key: keyToFind).first?.value.replacingOccurrences(of: "\\", with: ""){
        do{
            let HiveData = HiveAsString.data(using: .utf8)
            let decoder = JSONDecoder()
            let Result = try decoder.decode(Hive.self, from: HiveData!)
            return Result
        }catch{
            print("Error during decoding (\(error))")
        }
    }
    return Hive(Date(), Date(), Date(), false, 1, false, Date(), Date(), Date(), "","")
}

func SaveArrayOfHives(HivesToSave: [Hive]){
    if let HivesJsonData = try? JSONEncoder().encode(HivesToSave),
       let jsonString = String(data: HivesJsonData, encoding: .utf8){
        p.writeSync(team: TeamKey, tag: "", key: HivesKey, value: jsonString)
    }
}

func LoadArrayOfHives()-> [Hive]{
    var HivesAsString = p.readSync(team: TeamKey, tag: "", key: HivesKey).values.first
    if HivesAsString != nil {HivesAsString = HivesAsString?.replacingOccurrences(of: "\\", with: "")}else{return []}
    if let HivesData = HivesAsString?.data(using:.utf8){
        do{
            let decoder = JSONDecoder()
            let Result = try decoder.decode([Hive].self, from: HivesData)
            return Result
        }catch{
            print("Error during decoding (\(error))")
        }
    }
    return []
}


func ReloadFiles(keyToChange: String,newHive: Hive) -> Hive{
    var copyOfnewHive = newHive
    let oldHive = LoadFiles(keyToFind: newHive.id.uuidString)
    copyOfnewHive.id = oldHive.id
    SaveFiles(HiveToSave: copyOfnewHive, KeyToInsert: keyToChange)
    return copyOfnewHive
}

func ReloadFilesArray(hiveToAppend: Hive,GlobalHivesArray : ObservableList){
    var oldArray = LoadArrayOfHives()
    let index = oldArray.firstIndex(where: {$0.id == hiveToAppend.id})
    if(index != nil){oldArray.remove(at:index!)}
    oldArray.insert(hiveToAppend, at: 0)
    GlobalHivesArray.items = oldArray
    SaveArrayOfHives(HivesToSave: oldArray)
}
