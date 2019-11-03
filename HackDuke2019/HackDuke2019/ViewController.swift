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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func send(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
        print(self.messageField.text)
        if let text = self.messageField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        var newMessage = ChatMessage.init(message: self.messageField.text!, user: "user")
        GlobalVariables.sharedInstance.messagesArray.append(newMessage!)
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                print(textResponse)
                self.response.text = textResponse
                var newMessage = ChatMessage.init(message: textResponse, user: "bot")
                GlobalVariables.sharedInstance.messagesArray.append(newMessage!)
                self.reloadTable()
                //self.speechAndText(text: textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
        reloadTable()
    }
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var response: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func reloadTable(){
        let controller = storyboard!.instantiateViewController(withIdentifier: "MessagesTableViewController")
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        print(containerView)
        print(controller)
        print(controller.view)
        containerView.addSubview(controller.view)
//        //print (controller.view.frame.height)
//
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: controller.view.frame.height)
        print (scrollView.frame.height)
        print (scrollView.contentSize.height)
        controller.didMove(toParent: self)
        
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

