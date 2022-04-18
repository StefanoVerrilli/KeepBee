import Foundation
import SwiftUI

struct BackgroundView: View{
    var body: some View{
            Image("background-1")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}
