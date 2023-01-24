//
//  APIManager.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 24.01.2023.
//

import Foundation

struct APIManager {
    static var shared = APIManager()
    var timer = Timer()
    // This method loads and decodes data from the data.json file located at the root of the project.
    mutating func getDoorData(completion: @escaping (DoorData) -> Void) {
        guard let path = Bundle.main.path(forResource: "data",
                                            ofType: "json") else {
            return
        }
        let url = URL(filePath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            guard let dataResult = try JSONDecoder().decode(DoorData?.self, from: jsonData) else {
                return
            }
            //Simulates uploading data from the server via the API with a small delay by timer
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                completion(dataResult)
            })
        }
        catch {
            print("Error \(error)")
        }
    }
}

