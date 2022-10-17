//
//  ScoreViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 14/10/2022.
//

import UIKit

class ScoreViewController: UIViewController{
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var correct = 0
        var incorrect = 0
        for e in Singleton.sharedInstance.scores_arr{
            if e == 1{
                correct+=1
            }else if e == -1{
                incorrect+=1
            }
        }
        scoreLabel.text = "Your score is \(correct)/6."
        if correct < incorrect {
            view.backgroundColor = .red
        }else if incorrect < correct {
            view.backgroundColor = .green
        }else{
            view.backgroundColor = .white
        }
        
        
        
    }
    

}
