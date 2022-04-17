import Foundation

var hiveToFill = Hive()
var hivesNames = LoadHivesKey(keyToFind: "HivesKey")
let keyWordToFind = ["telai","nutrita","nutrire","è orfana","non è orfana","regina da sostituire","cella reale","kg","peso","pesa","diagramma"]

func StringMatching(stringToCheck: String) -> [String]{
    let targetHive = hivesNames.filter{stringToCheck.lowercased().range(of: "(?<![\\w\\d])\($0.hiveName)(?![\\w\\d])",options: [ .regularExpression,.caseInsensitive]) != nil}
    if targetHive.count != 1{return []}
    hiveToFill = LoadHive(keyToFind: targetHive.first!.id.uuidString)
    let keywordFound = keyWordToFind.filter{stringToCheck.range(of: "(?<![\\w\\d])\($0)(?![\\w\\d])",options: [.regularExpression,.caseInsensitive]) != nil}
    return keywordFound
}

func Tagger(stringToCheck: String,HivesArray: ObservableList) -> Hive?{
    hivesNames = HivesArray.items
    let CorrectedString = LiteralNumsHandler(StringToConvert: stringToCheck)
    let Keywords = StringMatching(stringToCheck: CorrectedString)
    if Keywords.isEmpty{return nil}
    for word in Keywords{
        CaseClassifier(CompleteString: CorrectedString, ParticularCase: word)
    }
    return hiveToFill
}

func CaseClassifier(CompleteString : String,ParticularCase: String){
    switch(ParticularCase){
    case "è orfana":
        hiveToFill.orphanHive = true
    case "non è orfana":
        hiveToFill.orphanHive = false
    case "diagramma":
        let regex = "(?<=non)[^\(ParticularCase)]+"
        let range = CompleteString.range(of: regex,options: [.caseInsensitive,.backwards,.regularExpression])?.lowerBound
        if range != nil{
            hiveToFill.hiveDiagram = false
        }else{
            hiveToFill.hiveDiagram = true
        }
    case "telai":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let regex = "[0-9]{1,2}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.loomsInside = result!}
    case "nutrire":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{
            print(result)
            hiveToFill.nextNutritionDay = result!}
    case "nutrita","nutrizione":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.lastNourishedDay = result!}
    case "regina da sostituire":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.queenChange = result!}
    case "cella reale":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.royalCellInserted = result!}
    case "pesa","peso","kg":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        print(substring)
        let regex = "[0-9]{1,3}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.hiveWheight = String(result!)}
    default:
        print("found some problems")
    }
}

