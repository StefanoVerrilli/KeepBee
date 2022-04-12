//
//  RecordingView.swift
//  Progratto_Team_G
//
//  Created by Stefano Verrilli on 09/04/22.
//

import Foundation
import SwiftUI

struct RecordingView: View{
    var body:some View{
             VStack(spacing:100){
                 VStack{
                     HStack{
                     Text("Track your hives")
                         .font(.system(size: 32, weight: .bold))
                         .multilineTextAlignment(.leading)
                         .frame(alignment:.leading)
                         Spacer()
                     }
                  Text("Shake the iPhone to record \nor press the mic")
                      .multilineTextAlignment(.leading)
                      .frame(maxWidth:.infinity,alignment: .leading)
                      .font(.system(size:26))
                 }.padding(.leading).padding(.top)
                 HStack{
                     ZStack{
                            Image(systemName:"circle.fill")
                             .font(.system(size:220)).foregroundColor(Color(UIColor(red: 237/255, green: 194/255, blue: 93/255, alpha: 1))).shadow(color: .black, radius: 4, x: 0, y: 0)
                    
                         Image(systemName:"mic.fill")
                             .font(.system(size:110)).foregroundColor(Color("CustomWhite")).shadow(color: .black, radius: 0, x: 0, y: 0)
                     }
                 }.padding(.vertical)
                 HStack{
                     Text("Futura stringa di speech to text aaaaaaa")
                 }
                 Spacer()
             }.background(BackgroundView())
    }
}

struct RecordingView_Previews: PreviewProvider{
    static var previews: some View{
        RecordingView()
            
    }
}
