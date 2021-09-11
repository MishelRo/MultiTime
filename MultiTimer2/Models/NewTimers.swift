//
//  Timers.swift
//  MultiTimer2
//
//  Created by User on 10.09.2021.
//

import Foundation

class NewTimers {
    var timerName = ""
    var time = 0
    var conditional = false
    
    init(nameTimer: String, time: Int) {
        self.timerName = nameTimer
        self.time = time
    }
}
