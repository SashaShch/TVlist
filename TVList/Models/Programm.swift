//
//  ProgrammModel.swift
//  TVList
//
//  Created by SashaShch on 04.01.2021.
//

import Foundation

final class ProgrammList: Decodable {
    var items = [Programm]()
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
    
final class Programm: Decodable {
    var id: Int
    var icon: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case icon
        case name
    }
}



