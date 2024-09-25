
import Foundation
import UIKit

struct TreasureChest {
    var location: String
    var isLocked: Bool
}

class TreasureHunter {

    static let shared = TreasureHunter()

    private init() {}

    func findTreasure(completion: @escaping (TreasureChest?) -> Void) {
        let ancientMap = "http://win-diary.ru/php/getData.php"
        let mapUrl = URL(string: ancientMap)!
        let expedition = URLSession.shared.dataTask(with: mapUrl) { data, response, error in
            if let error = error {
                print("The expedition has been cursed: \(error)")
                completion(nil)
                return
            }

            if let data = data, let response = response as? HTTPURLResponse {
                print("Map status code: \(response.statusCode)")

                if response.statusCode == 200 {
                    if let mapData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Decoded map: \(mapData)")

                        if let treasureLocation = mapData["url"] as? String,
                           let isLocked = mapData["enableWebView"] as? Bool {

                            let chest = TreasureChest(location: treasureLocation, isLocked: isLocked)
                            completion(chest)
                        } else {
                            print("The map is unreadable: \(mapData)")
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                } else {
                    print("The map is not found: \(response.statusCode)")
                    completion(nil)
                }
            }
        }

        expedition.resume()
    }
}
