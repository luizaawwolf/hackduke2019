//
//  NetworkManager.swift
//  HackDuke2019
//
//  Created by codeplus on 11/2/19.
//  Copyright © 2019 luiza. All rights reserved.
//

import Foundation
import Alamofire

class NetworkMgr {
    
    let MESSAGE_API_URL = "https://api.wit.ai/message?q="
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer YOUR_TOKEN_HERE"
    ]
    
    /// sharedInstance: the NetworkMgr singleton
    public static let sharedInstance = NetworkMgr()
    
    /// sendMessage(msg: String): Sends a message to Wit
    /// - Parameter msg: string of the message
    func sendMessage(msg: String) {
        
        let msgUrl = MESSAGE_API_URL + msg.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)!
        
        Alamofire.request(msgUrl, headers: headers).responseJSON { response in
            debugPrint("got response from Wit:")
            debugPrint(response)
        }
    }
}
