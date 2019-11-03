//
//  MessageTableViewCell.swift
//  HackDuke2019
//
//  Created by codeplus on 11/3/19.
//  Copyright © 2019 luiza. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var chatBubbleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chatBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        chatBubbleView.layer.cornerRadius = 15
        chatBubbleView.layer.masksToBounds = true
        
        addSubview(chatBubbleView)
        addSubview(messageText)
    }
    
    func initText(message:String){
        let attributedString = NSMutableAttributedString(string: message)
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: message, options: [], range: NSRange(location: 0, length: message.utf16.count))
        for match in matches {
            guard let range = Range(match.range, in: message) else { continue }
            let url = message[range]
            print(url)
            attributedString.addAttribute(.link, value: url, range: match.range)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTermTapped))
        messageText.addGestureRecognizer(tap)
        messageText.isUserInteractionEnabled = true
        
        messageText.attributedText = attributedString
    }
    
    @objc func handleTermTapped(gesture: UITapGestureRecognizer) {
//        let termString = termText as NSString
//        let termRange = termString.range(of: term)
//        let policyRange = termString.range(of: policy)
//
//        let tapLocation = gesture.location(in: termLabel)
//        let index = termLabel.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
//
//        if checkRange(termRange, contain: index) == true {
//            handleViewTermOfUse()
//            return
//        }
//
//        if checkRange(policyRange, contain: index) {
//            handleViewPrivacy()
//            return
//        }
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
