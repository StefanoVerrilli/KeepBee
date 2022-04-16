import Foundation

var hiveToFill = Hive()
var hivesNames = LoadArrayOfHives(keyToFind: "ArrayOfHives")
let keyWordToFind = ["telai","nutrita","nutrire","è orfana","non è orfana","regina da sostituire","cella reale","chili","peso","pesa","diagramma"]

func StringMatching(stringToCheck: String) -> [String]{
    let targetHive = hivesNames.filter{stringToCheck.lowercased().range(of: "(?<![\\w\\d])\($0.HiveName)(?![\\w\\d])",options: [ .regularExpression,.caseInsensitive]) != nil}
    if targetHive.count != 1{return []}
    hiveToFill = LoadHive(keyToFind: targetHive.first!.id.uuidString)
    let keywordFound = keyWordToFind.filter{stringToCheck.range(of: "(?<![\\w\\d])\($0)(?![\\w\\d])",options: [.regularExpression,.caseInsensitive]) != nil}
    return keywordFound
}

func Tagger(stringToCheck: String,HivesArray: HiveList) -> Hive?{
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
        hiveToFill.OrphanHive = true
    case "non è orfana":
        hiveToFill.OrphanHive = false
    case "diagramma":
        let regex = "(?<=non)[^diagramma]+"
        let range = CompleteString.range(of: regex,options: [.caseInsensitive,.backwards,.regularExpression])?.lowerBound
        if range != nil{
            hiveToFill.HiveDiagram = false
        }else{
            hiveToFill.HiveDiagram = true
        }
    case "telai":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let regex = "[0-9]{1,2}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.LoomsInside = result!}
    case "nutrire":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.NextNutritionDay = result!}
    case "nutrita","nutrizione":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck:String(substring))
        if result != nil{hiveToFill.LastNourishedDay = result!}
    case "regina da sostituire":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.QueenChange = result!}
    case "cella reale":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        let result = DetectDatesInString(StringToCheck: String(substring))
        if result != nil{hiveToFill.RoyalCellInserted = result!}
    case "pesa","peso","chili":
        let range = CompleteString.range(of: ParticularCase,options: [.backwards,.caseInsensitive])?.lowerBound
        let substring = CompleteString[range!...]
        print(substring)
        let regex = "[0-9]{1,3}"
        let result = DetectNumsInString(StringToCheck: String(substring), CompleteString: CompleteString, KeyWord: ParticularCase,regex: regex)
        if result != nil{hiveToFill.HiveWheight = String(result!)}
    default:
        print("found some problems")
    }
}

func LiteralNumsHandler(StringToConvert: String)->String{
    var TraslatedString: String = ""
    let nf = NumberFormatter()
    nf.numberStyle = .spellOut
    nf.locale = Locale(identifier: "it_IT")
    for word in StringToConvert.components(separatedBy: " "){
        let result = nf.number(from: word)?.stringValue
        if result != nil{
            TraslatedString.append(result!)
            TraslatedString.append(" ")
        }else{
            TraslatedString.append(word)
            TraslatedString.append(" ")
        }
    }
    return TraslatedString
}
