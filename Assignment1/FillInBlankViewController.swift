import UIKit

class FillInBlankViewController: UIViewController, UITextFieldDelegate{
    
    let questions: [String] = [
        "6+6=",
        "12x5=",
        "8/2="
    ]
    let corr_answers : [Int] = [
        12, 60, 4
    ]
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet var TapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    var curr_ind = 0
    var curr_ans : Float!
    
    override func viewDidLoad() {
        questionLabel.text = questions[curr_ind]
        nextButton.isHidden = true
        outcomeLabel.text = ""
        questionLabel.sizeToFit()
        finishLabel.isHidden = true
    }
    
    
    @IBAction func answerChanged(_ textField: UITextField) {
        curr_ans = Float(textField.text ?? "")
    }
    
    
    @IBAction func submit(_ sender: Any) {
        if (curr_ans != nil), Float(curr_ans)-Float(corr_answers[curr_ind]) == Float(0) {
            outcomeLabel.text = "CORRECT"
            outcomeLabel.textColor = .green
            Singleton.sharedInstance.scores_arr[curr_ind+3] = 1
        }else{
            outcomeLabel.text = "INCORRECT"
            outcomeLabel.textColor = .red
            Singleton.sharedInstance.scores_arr[curr_ind+3] = -1
        }
        nextButton.isHidden = false
        submitButton.isHidden = true
    }

    
    @IBAction func next(_ sender: Any) {
        curr_ind+=1
        if curr_ind == questions.count {
            finish()
        }else{
            questionLabel.text = questions[curr_ind]
            outcomeLabel.text = ""
            nextButton.isHidden = true
            submitButton.isHidden = false
            answerTextField.text = ""
        }
    }
    
    func finish(){
        headerLabel.removeFromSuperview()
        questionLabel.removeFromSuperview()
        answerTextField.removeFromSuperview()
        outcomeLabel.removeFromSuperview()
        submitButton.removeFromSuperview()
        nextButton.removeFromSuperview()
        finishLabel.isHidden = false
    }
    
    
    @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer){
        if answerTextField != nil{
            answerTextField.resignFirstResponder()
        }
    }
    
    // Text field validation
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existDecimal = textField.text?.range(of: ".")
        let replacementDecimal = string.range(of: ".")
        if existDecimal != nil, replacementDecimal != nil {
            return false
        }
        return true
    }
}
