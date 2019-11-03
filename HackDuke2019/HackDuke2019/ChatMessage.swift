//
//  ChatMessage.swift
//  
//
//  Created by codeplus on 11/3/19.
//

import Foundation

class ChatMessage{
    let message: String
    let user: String
    
    init?(message: String, user: String){
        self.message = message
        self.user = user
    }
}
