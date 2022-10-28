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
    let correct_anss : [String] = ["D","C","B"]
    let candidate_options : [[String]] = [
        ["A. The past tense of 'get' is 'got'",
         "B. Balboa is an island",
         "C. Paper is made from trees",
         "D. Macbook is a product of Microsoft"
        ],
        ["A. Fish has legs",
         "B. Coffee makes people feel sleepy",
         "C. Cups can contain water",
         "D. Wine has no alcohol in it"
        ],
        ["A. 2+6=9",
         "B. 3**3=27",
         "C. 4^2=8",
         "D. 9/3=2"
        ]
    ]

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var finishLabel: UILabel!
    
    @IBOutlet var redoButton: UIButton!
    
    var curr_ans : String = ""
    var curr_ind : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self

        headerLabel.isHidden = false
        questionLabel.isHidden = false
        picker.isHidden = false
        
        questionLabel.text = questions[curr_ind]

        
        outcomeLabel.text = ""
        nextButton.isHidden = true
        submitButton.isHidden = false
        finishLabel.isHidden = true
        redoButton.isHidden = true
        
        // Labels size to fit
        outcomeLabel.sizeToFit()
    }
    
    // MARK: buttons
    
    @IBAction func submit(_ sender: UIButton){
        if curr_ans == correct_anss[curr_ind]{
            outcomeLabel.text = "CORRECT"
            outcomeLabel.textColor = .green
            NumQStore.mcqScore[curr_ind] = 1
        }else{
            outcomeLabel.text = "INCORRECT"
            outcomeLabel.textColor = .red
            NumQStore.mcqScore[curr_ind] = -1
        }
        nextButton.isHidden = false
        submitButton.isHidden = true
    }
    
    
    
    @IBAction func next(_ sender: UIButton){
        curr_ind += 1
        if curr_ind == questions.count {
            curr_ind = 0
            finish()
        }else{
            viewDidLoad()
        }
    }
    
    func finish(){
        headerLabel.isHidden = true
        questionLabel.isHidden = true
        picker.isHidden = true
        finishLabel.isHidden = false
        redoButton.isHidden = false
        outcomeLabel.text = ""
        submitButton.isHidden = true
        nextButton.isHidden = true
    }
    
    
    @IBAction func redo(_ sender: Any) {
        NumQStore.refreshMcq()
        curr_ind = 0
        viewDidLoad()
    }
    
    // MARK: picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label :UILabel? = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: pickerView.frame.height/4))
//            label?.textAlignment = .left
        label?.text = candidate_options[curr_ind][row]
        label?.font = UIFont(name:"System",size:17.0)
        label?.lineBreakMode = .byWordWrapping
        label?.numberOfLines = 0
        label?.sizeToFit()
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row{
        case 0:
            curr_ans = "A"
        case 1:
            curr_ans = "B"
        case 2:
            curr_ans = "C"
        case 3:
            curr_ans = "D"
        default:
            curr_ans = ""
        }
    }
    


}

