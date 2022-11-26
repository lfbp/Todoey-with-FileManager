//
//  Item.swift
//  Todoey
//
//  Created by lpereira on 23/11/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct Item: Codable {
    var title: String = ""
    var done:Bool = false
}
