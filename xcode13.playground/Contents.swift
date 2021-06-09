import Foundation
import UIKit
import SwiftUI
import PlaygroundSupport

enum ServerError: Error {
  case invalidServerResponse
}

func fetchPhoto(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let error = error {
      completionHandler(nil, error)
    }
    
    if let data = data,
       let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode == 200 {
      DispatchQueue.main.async {
        completionHandler(UIImage(data: data), nil)
      }
    } else {
      completionHandler(nil, ServerError.invalidServerResponse)
    }
  }
  task.resume()
}

let urlString = "https://i.imgur.com/5H2qG1v.jpeg"

let url = URL(string: urlString)
var suiImage: Image?


fetchPhoto(url: url!) { image, error in
  guard let img = image else {
    print(error)
    return
  }
  suiImage = Image(uiImage: img)
  dump(img)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
  suiImage
    .map(PlaygroundPage.current.setLiveView)
}





