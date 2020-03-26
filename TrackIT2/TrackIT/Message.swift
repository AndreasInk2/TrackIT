//
//  Message.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-06-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit

enum MessageType {
    case user
    case botText
    case botForecast
}

class Message {
    
    var text: String = ""
    var date: Date
    var type: MessageType
    
    
    init(date: Date, type: MessageType) {
        self.date = date
        self.type = type
    }
    
    
    
    convenience init(text: String, date: Date, type: MessageType) {
        self.init(date: date, type: type)
        self.text = text
    }
    
    // MARK : create a text response for weather condition intnet
}
