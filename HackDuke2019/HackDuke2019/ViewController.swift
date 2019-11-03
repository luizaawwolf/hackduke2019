//
//  ViewController.swift
//  HackDuke2019
//
//  Created by codeplus on 11/2/19.
//  Copyright © 2019 luiza. All rights reserved.
//

import UIKit
import ApiAI
import AVFoundation

class ViewController: UIViewController {

    @IBAction func send(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
        print(self.messageField.text)
        if let text = self.messageField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                print(textResponse)
                self.response.text = textResponse
                //self.speechAndText(text: textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
    }
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var response: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    let speechSynthesizer = AVSpeechSynthesizer()
//
//    func speechAndText(text: String) {
//        let speechUtterance = AVSpeechUtterance(string: text)
//        speechSynthesizer.speak(speechUtterance)
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
//            self.response.text = text
//        }, completion: nil)
//    }
    

}

