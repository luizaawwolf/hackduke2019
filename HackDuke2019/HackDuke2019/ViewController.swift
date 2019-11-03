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

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func send(_ sender: Any) {
        sendRequest()
    }
    func sendRequest(){
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
                let messages = textResponse.components(separatedBy: "/newmessage")
                for message in messages{
                    self.formatWithURLs(text: message)
                    var newMessage = ChatMessage.init(message: message, user: "bot")
                    GlobalVariables.sharedInstance.messagesArray.append(newMessage!)
                }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        var newMessage = ChatMessage.init(message: "Hi, I'm Penny! I'm here to help you in your search for employment, housing, and financial independence. What are you looking for today?", user: "bot")
        GlobalVariables.sharedInstance.messagesArray.append(newMessage!)
        reloadTable()
        self.messageField.delegate = self
        messageField.layer.cornerRadius = 50.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {}
    @objc func keyboardWillHide(notification: NSNotification) {}
    
    func formatWithURLs(text:String)
    {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        print("URL")
        for match in matches {
            guard let range = Range(match.range, in: text) else { continue }
            let url = text[range]
            print(url)
        }
        
    }
    
    func reloadTable(){
        let controller = storyboard!.instantiateViewController(withIdentifier: "MessagesTableViewController") as! MessagesTableViewController
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
        controller.tableView.scrollToRow(at: IndexPath.init(row: GlobalVariables.sharedInstance.messagesArray.count-1, section: 0), at: .bottom, animated: false)
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

