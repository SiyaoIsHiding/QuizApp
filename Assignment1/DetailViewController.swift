//
//  DetailViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 27/10/2022.
//

import UIKit

class DetailViewController: UIViewController{
    var numQ : NumQ!
    
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
        questionField.text = numQ.question
        answerField.text = numberFormatter.string(from: NSNumber(value: numQ.answer))
        dateLabel.text = dateFormatter.string(from: numQ.date)
    }
    
}
