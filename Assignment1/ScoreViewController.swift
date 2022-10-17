//
//  ScoreViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 14/10/2022.
//

import UIKit

class ScoreViewController: UIViewController{
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var mcq_score: Int = 0
    var fib_score: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMcqScore(_:)), name: Notification.Name("mcq_score"), object: nil)
        scoreLabel.text = "Your score is \(mcq_score+fib_score)/6."
        NotificationCenter.default.addObserver(self, selector: #selector(updateFibScore(_:)), name: Notification.Name("fib_score"), object: nil)
    }
    
    
    
    @objc func updateMcqScore(_ notification: Notification){
        let newScore = notification.object as! Int
        mcq_score = newScore
    }
    
    @objc func updateFibScore(_ notification: Notification){
        let newScore = notification.object as! Int
        fib_score = newScore
    }
}
