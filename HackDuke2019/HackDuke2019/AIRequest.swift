//
//  AIRequest.swift
//  HackDuke2019
//
//  Created by codeplus on 11/2/19.
//  Copyright © 2019 luiza. All rights reserved.
//

import Foundation
import Alamofire
class AIRequest {
    
    var query: String
    var lang: String
    var sessionId: String
    
    init(query: String, lang: String) {
        self.query = query
        self.lang = lang
        self.sessionId = "WB-" + Date().description
    }
    
    func getHeaders() -> HTTPHeaders {
        let clientAccessToken = "84748a8ccff04b3593efa8f377f63dad"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + clientAccessToken,
        ]
        return headers
    }
    
    func toParameters() -> Parameters {
        
        let parameters: Parameters = [
            "query": query,
            "lang": lang,
            "sessionId": sessionId
        ]
        
        return parameters
    }
    
}
