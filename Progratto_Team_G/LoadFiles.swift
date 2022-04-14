//
//  LoadFiles.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 14/04/22.
//

import Foundation

func save(Hives: [Hive],InputKey: String){
    let data = Hives.map{try? JSONEncoder().encode($0)}
    UserDefaults.standard.set(data, forKey: InputKey)
}

func LoadHives(keyToFind: String)-> [Hive]{
    guard let encodedData = UserDefaults.standard.array(forKey: keyToFind)as? [Data] else{
        return []
    }
    return encodedData.map{try! JSONDecoder().decode(Hive.self, from: $0)}
}

func RemoveHives(keyToRemove:String){
    UserDefaults.standard.removeObject(forKey: keyToRemove)
}
