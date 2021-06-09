import Foundation
import UIKit

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
