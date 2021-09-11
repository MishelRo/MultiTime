//
//  MainViewModel.swift
//  MultiTimer2
//
//  Created by User on 10.09.2021.
//

import Foundation
class MainViewModel {
    
    static  var timers = [NewTimers]()
    
    func createNewTimer(name: String, time: Int, complession: @escaping()->()) {
     let newTimer = NewTimers(nameTimer: name, time: time)
        MainViewModel.timers.append(newTimer)
        complession()
    }

    func sorted() {
        let timersSort = MainViewModel.timers.sorted(by: { $0.time > $1.time })
        MainViewModel.timers = timersSort
    }

    func removeTimer(index: Int) {
        MainViewModel.timers.remove(at: index)
    }
}
