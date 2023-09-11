//
//  GestureTimer.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This timer can be used to calculate the elapsed time of any
 gesture.
 
 Call ``start()`` when a certain gesture starts then inspect
 ``elapsedTime`` to see how long the gesture has been active.
 */
public class GestureTimer {
    
    public init() {}
    
    private var date: Date?
    
    /**
     The time that has elapsed since ``start()`` was called.
     */
    public var elapsedTime: TimeInterval {
        guard let date = date else { return 0 }
        return Date().timeIntervalSince(date)
    }
    
    /**
     Start the timer.
     */
    public func start() {
        if date != nil { return }
        date = Date()
    }
}
