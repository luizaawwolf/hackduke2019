//
//  Message.swift
//  HackDuke2019
//
//  Created by codeplus on 11/2/19.
//  Copyright © 2019 luiza. All rights reserved.
//

import Foundation

enum MessageType {
    case user
    case botText
}

class Message {
    
    var text: String = ""
    var date: Date
    var type: MessageType
    
    init(date: Date, type: MessageType) {
        self.date = date
        self.type = type
    }
    
    convenience init(date: Date) {
        self.init(date: date, type: .botText)
    }
    
    convenience init(text: String, date: Date, type: MessageType) {
        self.init(date: date, type: type)
        self.text = text
    }
    
    convenience init() {
        self.init(date: Date(), type: .botText)
    }
    
    func getImage() -> String {
        switch self.type {
        case .user:
            return ""//"user.png"
        default:
            return ""//"bot.pdf"
        }
    }
    
}
