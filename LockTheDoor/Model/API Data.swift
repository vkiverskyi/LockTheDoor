//
//  APIData.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 14.01.2023.
//

import Foundation
import UIKit

struct Result: Codable {
    var data: [ResultItem]
}

struct ResultItem: Codable {
    let doorName: String
    let doorLocationName: String
    var statusLocked: Bool
}
