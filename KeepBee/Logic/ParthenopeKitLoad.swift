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

func SaveFiles(HiveToSave: Hive,KeyToInsert: String){
    if let jsonData = try? JSONEncoder().encode(HiveToSave){
        let jsonString = String(data: jsonData, encoding: .utf8)
        p.writeSync(team: TeamKey, tag: "", key: KeyToInsert, value: jsonString)
    }
    
}

func LoadFiles(keyToFind: String) -> Hive{
    if let HiveAsString = p.readSync(team: TeamKey, tag: "", key: keyToFind).first?.value{
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

func SaveArrayOfHives(HivesToSave: [Hive],keyToInsert: String){
    if let HivesJsonData = try? JSONEncoder().encode(HivesToSave),
       let jsonString = String(data: HivesJsonData, encoding: .utf8){
        p.writeSync(team: TeamKey, tag: "", key: keyToInsert, value: jsonString)
    }
}

func LoadArrayOfHives(keyToInsert: String)-> [Hive]{
    var HivesAsString = p.readSync(team: TeamKey, tag: "", key: keyToInsert).values.first
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
