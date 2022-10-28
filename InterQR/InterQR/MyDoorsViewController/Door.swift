//
//  Door.swift
//  InterQR
//
//  Created by Илья Мишин on 16.09.2022.
//

import UIKit

enum DoorState {
    case locked
    case unlocking
    case unlocked
}

class Door {
    weak var delegate: DoorDelegate?
    
    let id: Int
    let title: String
    let location: String
    var state: DoorState {
        didSet {
            delegate?.stateChanged(newState: state)
        }
    }
    
    init(id: Int, title: String, location: String, state: DoorState) {
        self.id = id
        self.title = title
        self.location = location
        self.state = state 
    }
}
