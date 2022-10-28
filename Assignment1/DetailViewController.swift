//
//  DetailViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 27/10/2022.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate{
    var numQ : NumQ!
    var new: Bool = false
    
    @IBOutlet var questionField: UITextField!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let numberFormatter:  NumberFormatter = {
        let f = NumberFormatter()
        f.maximumFractionDigits = 2
        f.minimumFractionDigits = 2
        return f
    }()
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !new {questionField.text = numQ.question
            answerField.text = numberFormatter.string(from: NSNumber(value: numQ.answer))
            dateLabel.text = dateFormatter.string(from: numQ.date)
        }else{
            dateLabel.text = ""
        }
        
    }
    
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        if !new{
            numQ.question = questionField.text ?? ""
            if let answer = answerField.text, let value = numberFormatter.number(from: answer){
                numQ.answer = value.floatValue
            }else{
                numQ.answer = 0
            }
        }else{
            let newQuestion = questionField.text ?? ""
            let newAnswer: Float
            if let answer = answerField.text, let value = numberFormatter.number(from: answer){
                newAnswer = value.floatValue
            }else{
                newAnswer = 0
            }
            
            let newNumQ = NumQ(newQuestion, newAnswer)
            NumQStore.createNumQ(numq: newNumQ)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
