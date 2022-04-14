//
//  LoadFiles.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 14/04/22.
//

import Foundation

//Those functions are made to store and read Hives

func saveHive(myHive: Hive,InputKey: String){
    do{
        let encoder = JSONEncoder()
        let result = try encoder.encode(myHive)
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

func saveHivesArray(myArray: [Hive],keyToFind: String){
    let date = myArray.map{try? JSONEncoder().encode($0)}
    UserDefaults.standard.set(date, forKey: keyToFind)
}

func LoadHivesArray(keyToFind: String)-> [Hive]{
    guard let encodedData = UserDefaults.standard.array(forKey: keyToFind)as? [Data] else{
        return []
    }
    return encodedData.map{try! JSONDecoder().decode(Hive.self, from: $0)}
}

//This function here is made to delete elements from UserDefaults

func RemoveHives(keyToRemove:String){
    UserDefaults.standard.removeObject(forKey: keyToRemove)
}
