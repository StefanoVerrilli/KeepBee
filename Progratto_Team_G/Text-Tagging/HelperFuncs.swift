//
//  HelperFuncs.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 15/04/22.
//

import Foundation

func DetectDatesInString(StringToCheck:String)-> Date?{
    let daysRegex = "[a-z]{2,3} [0-9]{1,2} giorni"
    let regex = "[0-9]{1,2} [a-z]{1,10} [0-9]{4}"
    var DistanceDate:Int = 10000
    var Distancedays:Int = 10000
    var Datesubstring: Substring = " "
    var Dayssubstring: Substring = " "
    let MonthsArray = ["january","february","march","april","may","june","july","august","september","october","november","december"]
    let MonthFound: [String]
    if let range = StringToCheck.range(of:regex,options: .regularExpression){
        Datesubstring = StringToCheck[range.lowerBound..<range.upperBound]
        let index = StringToCheck.index(StringToCheck.startIndex, offsetBy: 0)
        DistanceDate = StringToCheck.distance(from: index, to: range.lowerBound)
        }
    
    if let rangeDays = StringToCheck.range(of: daysRegex,options: .regularExpression){
        Dayssubstring = StringToCheck[rangeDays.lowerBound..<rangeDays.upperBound]
        let index = StringToCheck.index(StringToCheck.startIndex, offsetBy: 0)
        Distancedays = StringToCheck.distance(from: index, to: rangeDays.lowerBound)
         }
    
    if Distancedays < DistanceDate{
        let CurrentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = Int(Dayssubstring.components(separatedBy: " ")[1])
        let AddedDate = Calendar.current.date(byAdding: dateComponent,to: CurrentDate)
        return AddedDate!
    }else{
        MonthFound = FindWord(StringToCheck: String(Datesubstring), WhereToFind: MonthsArray)
        if !MonthFound.isEmpty{
            let DateInNums = Datesubstring.replacingOccurrences(of: MonthFound[0], with: String(DataHandler(MonthName: MonthFound[0])))
            return StringToDate(StringToConvert: DateInNums)
        }else{
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
    let Items = StringToConvert.components(separatedBy: " ")
    DateComponent.day = Int(Items[0])
    DateComponent.month = Int(Items[1])
    DateComponent.year = Int(Items[2])
    let fullDate = calender.date(from: DateComponent)
    return fullDate!
}


func DetectNumsInString(StringToCheck:String,CompleteString:String,KeyWord: String,regex: String)-> Int?{
    var Distance: Int = 10000
    var ReversedDistance:Int = 10000
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

func DataHandler(MonthName: String)-> Int{
    switch(MonthName){
case "january":
        return 01
case "february":
        return 02
case "march":
        return 03
case "april":
        return 04
case "may":
        return 05
case "june":
        return 06
case "july":
        return 07
case "august":
        return 08
case "september":
        return 09
case "october":
        return 10
case "november":
        return 11
case "december":
        return 12
    default:
        return 0
    }
}
