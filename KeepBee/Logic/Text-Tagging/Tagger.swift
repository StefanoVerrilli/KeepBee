import Foundation

var hiveToFill = Hive()
var hivesNames = LoadArrayOfHives()
//let keyWordToFind = ["telai","nutrita","nutrire","è orfana","non è orfana","regina inserita","regina da sostituire","cella reale","kg","peso","pesa","diagramma","sciame","nutrito"]
let keyWordToFind = ["looms","loom","nourished","fed","is orphan","not an orhphan","queen","royal","kg","weighs","weight","diagram","swarm"]

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

/*func CaseClassifier(CompleteString : String,ParticularCase: String){
    switch(ParticularCase){
    case "è orfana":
        hiveToFill.orphanHive = true
    case "non è orfana":
        hiveToFill.orphanHive = false
    case "diagramma":
        let regex = "(?<=non)[^\(ParticularCase)]+"
        let range = CompleteString.range(of: regex,options: [.caseInsensitive,.backwards,.regularExpression])?.lowerBound
        if range != nil
        {
            hiveToFill.hiveDiagram = false
        }else{
            hiveToFill.hiveDiagram = true}
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
        if result != nil{hiveToFill.nextNutritionDay = result!}
    case "nutrita","nutrizione","nutrito":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.lastNourishedDay = result!}
    case "regina da sostituire":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.queenChange = result!}
    case "regina inserita":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.queenInserted = result!}
    case "cella reale":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.royalCellInserted = result!}
    case "sciame":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.swarmPickedUp = result!}
    case "pesa","peso","kg":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let regex = "[0-9]{1,3}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.hiveWheight = String(result!)}
    default:
        print("found some problems")
    }
}
*/


func CaseClassifier(CompleteString : String,ParticularCase: String){
    switch(ParticularCase){
    case "is an orphan","is orphan":
        hiveToFill.orphanHive = true
    case "not an orphan","isn't an orphan","isn't orphan":
        hiveToFill.orphanHive = false
    case "diagram":
        let regex = "(?<=doesn't)[^\(ParticularCase)]+"
        let range = CompleteString.range(of: regex,options: [.caseInsensitive,.backwards,.regularExpression])?.lowerBound
        if range != nil
        {
            hiveToFill.hiveDiagram = false
        }else{
            hiveToFill.hiveDiagram = true}
    case "looms","loom":
        let regexLoom = "loom(s)?"
        let range = CompleteString.range(of: regexLoom,options: [.backwards,.caseInsensitive,.regularExpression])?.lowerBound
        let substring = CompleteString[range!...]
        let regex = "[0-9]{1,2}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.loomsInside = result!}
    case "to be fed","to be nourished":
        let range = CompleteString.range(of: "(?<![\\w\\d])\(ParticularCase)(?![\\w\\d])",options: [.backwards,.caseInsensitive,.regularExpression])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.nextNutritionDay = result!}
    case "fed","nourished":
        let range = CompleteString.range(of: "(?<![\\w\\d])\(ParticularCase)(?![\\w\\d])",options: [.backwards,.caseInsensitive,.regularExpression])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.lastNourishedDay = result!}
    case "queen":
        var regex = "(?<=\(ParticularCase))[^changed]+"
        var range = CompleteString.range(of: regex,options: [.backwards,.caseInsensitive,.regularExpression])?.lowerBound
        if range != nil{
            let substring = CompleteString[range!...]
            let result = DetectDatesInString(StringToCheck: String(substring))
            if result != nil{hiveToFill.queenChange = result!}}
        regex = "(?<=\(ParticularCase))[^inserted]+"
        range = CompleteString.range(of: regex,options: [.backwards,.caseInsensitive,.regularExpression])?.lowerBound
        if range != nil{
            let substringInsert = CompleteString[range!...]
            let resultInsert = DetectDatesInString(StringToCheck: String(substringInsert))
            if resultInsert != nil{hiveToFill.queenInserted = resultInsert!}}
    case "royal":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.royalCellInserted = result!}
    case "swarm":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.swarmPickedUp = result!}
    case "weighs","weight","kg":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let regex = "[0-9]{1,3}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.hiveWheight = String(result!)}
    default:
        print("found some problems")
    }
}
