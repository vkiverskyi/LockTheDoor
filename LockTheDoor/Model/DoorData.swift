//
//  DoorData.swift
//  LockTheDoor
//
//  Created by Vitalii Kiverskyi on 14.01.2023.
//

import Foundation

struct DoorData: Codable {
    var data: [DoorDataItems]
}

struct DoorDataItems: Codable {
    let doorName: String
    let doorLocationName: String
    var statusLocked: Bool
}
