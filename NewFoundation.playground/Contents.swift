import Foundation
import PlaygroundSupport
import SwiftUI

var date = Date().formatted(date: .abbreviated, time: .standard)

var thanks = AttributedString("Thank you!")

PlaygroundPage.current.setLiveView(
  NavigationView {
    VStack {
      Text(thanks)
      Text(date)
    }
  }
)

