//
//  ViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 14/10/2022.
//

import UIKit

class McqViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let questions: [String] = [
        "Which statement is false?",
        "Which statement is true?",
        "Which equition holds true?"
    ]
    let correct_anss : [String] = [
        "D",
        "C",
        "B"
    ]
    let candidate_options : [[String]] = [
        ["A. The past tense of 'get' is 'got'",
         "B. Balboa is an island",
         "C. Paper is made from trees",
         "D. Macbook is a product of Microsoft"
        ],
        ["A. C and Ca are the same chemical element",
         "B. Coffee usually makes people feel sleepy",
         "C. Human beings need to drink enough water to keep alive",
         "D. Alcohol is harmless to people's health"
        ],
        ["A. 2+6=9",
         "B. 3**3=27",
         "C. 4^2=8",
         "D. 9/3=2"
        ]
    ]

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionA: UILabel!
    @IBOutlet weak var optionB: UILabel!
    @IBOutlet weak var optionC: UILabel!
    @IBOutlet weak var optionD: UILabel!
    
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    
    var options: [String] = ["A","B","C","D"]
    var curr_ans : String = ""
    var curr_ind : Int = 0
    var score_arr = [0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        questionLabel.text = questions[curr_ind]
        optionA.text = candidate_options[curr_ind][0]
        optionB.text = candidate_options[curr_ind][1]
        optionC.text = candidate_options[curr_ind][2]
        optionD.text = candidate_options[curr_ind][3]
        outcomeLabel.text = ""
        nextButton.isHidden = true
        
        // Labels size to fit
        optionA.sizeToFit()
        optionB.sizeToFit()
        optionC.sizeToFit()
        optionD.sizeToFit()
        outcomeLabel.sizeToFit()
    }
    
    // MARK: buttons
    
    @IBAction func submit(_ sender: UIButton){
        if curr_ans == correct_anss[curr_ind]{
            outcomeLabel.text = "You are correct!"
            score_arr[curr_ind] = 1
            let score_sum = score_arr.reduce(0, +)
            NotificationCenter.default.post(name: Notification.Name("mcq_score"), object: score_sum)
        }else{
            outcomeLabel.text = "You are wrong. The correct answer is \(correct_anss[curr_ind])."
            score_arr[curr_ind] = 0
            let score_sum = score_arr.reduce(0,+)
            NotificationCenter.default.post(name: Notification.Name("mcq_score"), object: score_sum)
        }
        nextButton.isHidden = false
    }
    
    
    
    @IBAction func next(_ sender: UIButton){
        curr_ind += 1
        if curr_ind == questions.count {
            curr_ind = 0
        }
        questionLabel.text = questions[curr_ind]
        optionA.text = candidate_options[curr_ind][0]
        optionB.text = candidate_options[curr_ind][1]
        optionC.text = candidate_options[curr_ind][2]
        optionD.text = candidate_options[curr_ind][3]
        outcomeLabel.text = ""
        nextButton.isHidden = true
    }
    
    // MARK: picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        curr_ans = options[row]
    }
    


}

