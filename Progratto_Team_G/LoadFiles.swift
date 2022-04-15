//
//  LoadFiles.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 14/04/22.
//

import Foundation

//Those functions are made to store and read Hives

func saveHive(hiveToSave: Hive,InputKey: String){
    do{
        let encoder = JSONEncoder()
        let result = try encoder.encode(hiveToSave)
        UserDefaults.standard.set(result,forKey: InputKey)
    }catch{
        print("Error during encoding (\(error))")
    }
}

func LoadHive(keyToFind: String) -> Hive{
    if let data = UserDefaults.standard.data(forKey: keyToFind){
        do{
            let decoder = JSONDecoder()
            let Result = try decoder.decode(Hive.self, from: data)
            return Result
        }catch{
            print("Error during decoding (\(error))")
        }
    }
    return Hive(Date(), Date(), Date(), false, 1, false, Date(), Date(), Date(), "")
}

//Those functions are made to store Array of hives in UserDefaults

func saveArrayOfHives(myArray: [Hive],keyToFind: String){
    let date = myArray.map{try? JSONEncoder().encode($0)}
    UserDefaults.standard.set(date, forKey: keyToFind)
}

func LoadArrayOfHives(keyToFind: String)-> [Hive]{
    guard let encodedData = UserDefaults.standard.array(forKey: keyToFind)as? [Data] else{
        return []
    }
    return encodedData.map{try! JSONDecoder().decode(Hive.self, from: $0)}
}

func ReloadHive(keyToChange: String,newHive: Hive) -> Hive{
    var copyOfnewHive = newHive
    let oldHive = LoadHive(keyToFind: keyToChange)
    RemoveHives(keyToRemove: keyToChange)
    copyOfnewHive.id = oldHive.id
    saveHive(hiveToSave: copyOfnewHive, InputKey: keyToChange)
    return copyOfnewHive
}

func ReloadNewArray(hiveToAppend: Hive){
    var oldArray = LoadArrayOfHives(keyToFind: "ArrayOfHives")
    let index = oldArray.firstIndex(where: {$0.id == hiveToAppend.id})
    if(index != nil){oldArray.remove(at:index!)}
    oldArray.append(hiveToAppend)
    RemoveHives(keyToRemove: "ArrayOfHives")
    saveArrayOfHives(myArray: oldArray, keyToFind: "ArrayOfHives")
}
//This function here is made to delete elements from UserDefaults
func RemoveHives(keyToRemove:String){
    UserDefaults.standard.removeObject(forKey: keyToRemove)
}
