import Foundation
import AVFoundation
var hiveToFill = Hive()
var hivesNames = LoadArrayOfHives(keyToFind: "ArrayOfHives")
let keyWordToFind = ["telai","nutrita","nutrire","è orfana","non è orfana","regina da sostituire","cella reale","chili","peso","pesa"]

func StringMatching(stringToCheck: String) -> [String]{
    let targetHive = hivesNames.filter{stringToCheck.range(of: "(?<![\\w\\d])\($0.HiveName)(?![\\w\\d])",options: .regularExpression) != nil}
    if targetHive.count != 1{return []}
    hiveToFill = LoadHive(keyToFind: targetHive.first!.id.uuidString)
    var keywordFound: Array<String>
    keywordFound = keyWordToFind.filter{stringToCheck.range(of: "(?<![\\w\\d])\($0)(?![\\w\\d])",options: .regularExpression) != nil}
    return keywordFound
}

func Tagger(stringToCheck: String) -> Hive?{
    let Keywords = StringMatching(stringToCheck: stringToCheck)
    if Keywords.isEmpty{return nil}
    for word in Keywords{
        CaseClassifier(CompleteString: stringToCheck, ParticularCase: word)
    }
    return hiveToFill
}

func CaseClassifier(CompleteString : String,ParticularCase: String){
    switch(ParticularCase){
    case "è orfana":
        hiveToFill.OrphanHive = true
    case "non è orfana":
        hiveToFill.OrphanHive = false
    case "telai":
        let range = CompleteString.range(of: ParticularCase,options: .backwards)?.lowerBound
        let substring = CompleteString[range!...]
        let regex = "[0-9]{1,2}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.LoomsInside = result!}
    case "nutrita","nutrire":
        let range = CompleteString.range(of: ParticularCase,options: .backwards)?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.NextNutritionDay = result!}
    case "regina da sostituire":
        let range = CompleteString.range(of: ParticularCase,options: .backwards)?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.QueenChange = result!}
    case "cella reale":
        let range = CompleteString.range(of: ParticularCase,options: .backwards)?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.RoyalCellInserted = result!}
    case "pesa","peso","chili":
        let range = CompleteString.range(of: ParticularCase,options: .backwards)?.lowerBound
        let substring = CompleteString[range!...]
        print(substring)
        let regex = "[0-9]{1,3}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.HiveWheight = String(result!)}
    default:
        print("found some problems")
    }
}

