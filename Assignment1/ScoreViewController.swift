//
//  ScoreViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 14/10/2022.
//

import UIKit

class ScoreViewController: UIViewController{
    //TODO: out of 6
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NumQStore.refreshNumQ()
        viewWillAppear(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var correct = 0
        var incorrect = 0
        for e in NumQStore.mcqScore{
            if e == 1{
                correct+=1
            }else if e == -1{
                incorrect+=1
            }
        }
        for e in NumQStore.numQScore{
            if e == 1{
                correct+=1
            }else if e == -1{
                incorrect+=1
            }
        }
        scoreLabel.text = "Your score is \(correct)/\(NumQStore.mcqScore.count+NumQStore.numQScore.count)."
        if correct < incorrect {
            view.backgroundColor = .red
        }else if incorrect < correct {
            view.backgroundColor = .green
        }else{
            view.backgroundColor = .white
        }
        
        
        
    }
    

}
