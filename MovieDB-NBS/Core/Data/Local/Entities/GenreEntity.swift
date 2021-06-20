//
//  GenreEntity.swift
//  MovieDB-NBS
//
//  Created by Ahmad Zaky on 17/06/21.
//

import Foundation
import RealmSwift

class GenreEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
