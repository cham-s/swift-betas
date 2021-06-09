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
      return
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
  guard let img = image else { return }
  suiImage = Image(uiImage: img)
  dump(img)
}

//DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//  suiImage
//    .map(PlaygroundPage.current.setLiveView)
//}

func fetchPhoto(url: URL) async throws -> UIImage {
  let (data, response) = try await URLSession.shared.data(from: url)
  print("inside after await")
  guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200 else {
          throw ServerError.invalidServerResponse
        }
  
  guard let image = UIImage(data: data) else {
    throw ServerError.invalidServerResponse
  }
  
  return image
}

func after() {
  print("inside after")
}

async {
  let im = try! await  fetchPhoto(url: url!)
  after()
}
  

