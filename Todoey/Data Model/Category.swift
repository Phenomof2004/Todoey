//
//  Category.swift
//  Todoey
//
//  Created by admin on 3/1/18.
//  Copyright © 2018 MVMA. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
