//
//  DoorDelegate.swift
//  InterQR
//
//  Created by Илья Мишин on 17.09.2022.
//

import UIKit

protocol DoorDelegate: AnyObject {
    func stateChanged(newState: DoorState)
}
