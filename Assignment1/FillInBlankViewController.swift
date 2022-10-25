import UIKit

class FillInBlankViewController: UIViewController, UITextFieldDelegate{
    
    var NumQs :[NumQ] = NumQStore.allNumQ
    
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
        NumQs = NumQStore.allNumQ
        questionLabel.text = NumQs[curr_ind].question
        nextButton.isHidden = true
        outcomeLabel.text = ""
        questionLabel.sizeToFit()
        finishLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        viewDidLoad()
        print(NumQs)
    }
    
    @IBAction func answerChanged(_ textField: UITextField) {
        curr_ans = Float(textField.text ?? "")
    }
    
    
    @IBAction func submit(_ sender: Any) {
        if (curr_ans != nil), Float(curr_ans)-Float(NumQs[curr_ind].answer) == Float(0) {
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
        if curr_ind == NumQs.count {
            finish()
        }else{
            questionLabel.text = NumQs[curr_ind].question
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
