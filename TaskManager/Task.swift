//
//  Task.swift
//  TaskManager
//
//  Created by Clarette Terrasi on 09/01/2020.
//  Copyright © 2020 Clarette Terrasi Díaz. All rights reserved.
//

import Foundation

enum TaskType {
    case title(String)
    case detail(String)
    case isComplete(Bool)
    case date(Date)
}

struct Task {
    var title: TaskType
    var detail: TaskType
    var
}
