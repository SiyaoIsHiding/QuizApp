import UIKit

class FillInBlankViewController: UIViewController{
    
    let questions: [String] = [
        "My laptop runs out of elec_______.",
        "It is a bass, not a gui___.",
        "Purple can be created by combining red and b___."
    ]
    let corr_answers : [String] = [
        "tricity", "tar", "lue"
    ]
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet var TapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var OutcomeLabel: UILabel!
    
    var curr_ind = 0
    var curr_ans :String = ""
    var score_arr = [0,0,0]
    
    override func viewDidLoad() {
        questionLabel.text = questions[curr_ind]
        nextButton.isHidden = true
        OutcomeLabel.text = ""
        questionLabel.sizeToFit()
    }
    
    
    @IBAction func answerChanged(_ textField: UITextField) {
        curr_ans = textField.text ?? ""
    }
    
    
    @IBAction func submit(_ sender: Any) {
        if curr_ans == corr_answers[curr_ind] {
            OutcomeLabel.text = "You are correct!"
            score_arr[curr_ind] = 1
            let score_sum = score_arr.reduce(0, +)
            NotificationCenter.default.post(name: Notification.Name("fib_score"), object: score_sum)
        }else{
            OutcomeLabel.text = "You are wrong. The correct answer is '\(corr_answers[curr_ind])'."
            score_arr[curr_ind] = 0
            let score_sum = score_arr.reduce(0, +)
            NotificationCenter.default.post(name: Notification.Name("fib_score"), object: score_sum)
        }
        nextButton.isHidden = false
    }

    
    @IBAction func next(_ sender: Any) {
        curr_ind+=1
        if curr_ind == questions.count {
            curr_ind = 0
        }
        questionLabel.text = questions[curr_ind]
        OutcomeLabel.text = ""
        nextButton.isHidden = true
        answerTextField.text = ""
    }
    
    @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer){
        answerTextField.resignFirstResponder()
    }
}
