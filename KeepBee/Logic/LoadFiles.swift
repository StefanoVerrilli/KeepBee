import Foundation

//Those functions are made to store and read Hives

/*func saveHive(hiveToSave: Hive,inputKey: String){
    do{
        let encoder = JSONEncoder()
        let result = try encoder.encode(hiveToSave)
        UserDefaults.standard.set(result,forKey: inputKey)
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
    return Hive(Date(), Date(), Date(), false, 1, false, Date(), Date(), Date(), "","")
}

//Those functions are made to store Array of hives in UserDefaults

func SaveHivesKey(myArray: [Hive],keyToFind: String){
    let date = myArray.map{try? JSONEncoder().encode($0)}
    UserDefaults.standard.set(date, forKey: keyToFind)
}

func LoadHivesKey(keyToFind: String)-> [Hive]{
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
    saveHive(hiveToSave: copyOfnewHive, inputKey: keyToChange)
    return copyOfnewHive
}

func ReloadNewArray(hiveToAppend: Hive,GlobalHivesArray : ObservableList){
    var oldArray = LoadHivesKey(keyToFind: "HivesKey")
    let index = oldArray.firstIndex(where: {$0.id == hiveToAppend.id})
    if(index != nil){oldArray.remove(at:index!)}
    oldArray.insert(hiveToAppend, at: 0)
    GlobalHivesArray.items = oldArray
    RemoveHives(keyToRemove: "HivesKey")
    SaveHivesKey(myArray: oldArray, keyToFind: "HivesKey")
}

//This function here is made to delete elements from UserDefaults
func RemoveHives(keyToRemove:String){
    UserDefaults.standard.removeObject(forKey: keyToRemove)
}
*/
