import Foundation

//let CurrentLang = "it_IT_Posix"
let CurrentLang = "en_US_Posix"

func DetectDatesInString(StringToCheck:String)-> Date?{
    let daysRegex = "[0-9]{1,2} day([a-z]{1})?"
    let regex = "[0-9]{1,2}(th)? [a-z]{1,10} [0-9]{4}"
    var DistanceDate:Int = Int.max
    var Distancedays:Int = Int.max
    var Datesubstring: Substring?
    var Dayssubstring: Substring?
    var LocalizedCalendar = Calendar.autoupdatingCurrent
    LocalizedCalendar.locale = Locale(identifier: CurrentLang)
    if let range = StringToCheck.range(of:regex,options: [.regularExpression,.caseInsensitive]){
        Datesubstring = StringToCheck[range.lowerBound..<range.upperBound]
        let index = StringToCheck.index(StringToCheck.startIndex, offsetBy: 0)
        DistanceDate = StringToCheck.distance(from: index, to: range.lowerBound)
        }
    
    if let rangeDays = StringToCheck.range(of: daysRegex,options: [.regularExpression,.caseInsensitive]){
        Dayssubstring = StringToCheck[rangeDays.lowerBound..<rangeDays.upperBound]
        let index = StringToCheck.index(StringToCheck.startIndex, offsetBy: 0)
        Distancedays = StringToCheck.distance(from: index, to: rangeDays.lowerBound)
         }
    if Distancedays < DistanceDate{
        let CurrentDate = Date()
        var dateComponent = DateComponents()
        if Dayssubstring != nil{
            dateComponent.day = Int(Dayssubstring!.components(separatedBy: " ")[0])}
        let AddedDate = Calendar.current.date(byAdding: dateComponent,to: CurrentDate)
        return AddedDate!
    }else{
        if Datesubstring != nil{
        if let DateFound = DataHandler(StringToConvert: String(Datesubstring!)){
            return StringToDate(StringToConvert: DateFound)
        }else{
            return nil
        }}else{
            return nil
        }
    }
}

func FindWord(StringToCheck:String,WhereToFind:Array<String>)->[String]{
    let Foundings = WhereToFind.filter{StringToCheck.range(of: $0) != nil}
    return Foundings
}

func StringToDate(StringToConvert: String)-> Date{
    let calender = Calendar.current
    var DateComponent = DateComponents()
    DateComponent.calendar = calender
    let Items = StringToConvert.components(separatedBy: "-")
    DateComponent.day = Int(Items[0])
    DateComponent.month = Int(Items[1])
    DateComponent.year = Int(Items[2])
    let fullDate = calender.date(from: DateComponent)
    return fullDate!
}


func DetectNumsInString(StringToCheck:String,CompleteString:String,KeyWord: String,regex: String)-> Int?{
    var Distance: Int = Int.max
    var ReversedDistance:Int = Int.max
    var substringReversed: Substring = ""
    var Mysubstring: Substring = ""
    if let Calcrange = StringToCheck.range(of: regex,options: .regularExpression){
        Mysubstring = StringToCheck[Calcrange.lowerBound..<Calcrange.upperBound]
        let index = StringToCheck.index(StringToCheck.startIndex, offsetBy: 0)
        Distance = StringToCheck.distance(from: index, to: Calcrange.lowerBound)
    }
    let result = CompleteString.components(separatedBy: " ").map{$0}.reversed().joined(separator: " ")
    let CutRange = result.range(of: KeyWord)!
    let Mystring = result[CutRange.lowerBound..<result.endIndex]
    if  let CalcrangeReverse = Mystring.range(of: regex,options: .regularExpression){
        substringReversed = Mystring[CalcrangeReverse.lowerBound..<CalcrangeReverse.upperBound]
        let index = Mystring.index(Mystring.startIndex, offsetBy: 0)
        ReversedDistance = Mystring.distance(from: index, to: CalcrangeReverse.lowerBound)
    }
    if Distance < ReversedDistance{
        return Int(Mysubstring)
    }else{
        return Int(substringReversed)
    }
}

func DataHandler(StringToConvert: String)-> String?{
    /*if StringToConvert.components(separatedBy: " ").count - 1 == 1 {
        StringToCheck.append(" ")
        StringToCheck.append(String(Calendar.current.component(.year, from: Date())))
    }*/
    let myformatter = DateFormatter()
    myformatter.locale = Locale(identifier: CurrentLang)
    myformatter.dateFormat = "dd-MM-yyyy"
    myformatter.timeZone = TimeZone.current
    let DateToConvert = myformatter.date(from: StringToConvert)
    if DateToConvert != nil{
        print(myformatter.string(from: DateToConvert!))
        return myformatter.string(from: DateToConvert!)
    }else{
        return nil
    }
}

func LiteralNumsHandler(StringToConvert: String)->String{
    var TraslatedString: String = ""
    let nf = NumberFormatter()
    nf.numberStyle = .spellOut
    nf.locale = Locale(identifier: CurrentLang)
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
