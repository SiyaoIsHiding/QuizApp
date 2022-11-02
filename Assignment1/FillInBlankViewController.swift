import UIKit

class FillInBlankViewController: UIViewController, UITextFieldDelegate{
    //TODO: save and load data
    var NumQs :[NumQ] = NumQStore.allNumQ
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet var TapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet var redoButton: UIButton!
    
    var curr_ind : Int = 0
    var curr_ans : Float!
    
    override func viewDidLoad() {
        NumQStore.vc = self
        curr_ind = 0
        NumQs = NumQStore.allNumQ
        
        toggleFinish(toFinish: false)
        NumQStore.numQScore = Array(repeating: 0, count: NumQs.count)
        questionLabel.sizeToFit()
    }
    
    func toggleFinish(toFinish: Bool){
        if !toFinish {
            if (NumQs.count > 0) {
                questionLabel.text = NumQs[curr_ind].question
                headerLabel.isHidden = false
                questionLabel.isHidden = false
                answerTextField.isHidden = false
                submitButton.isHidden = false
            }else{
                headerLabel.isHidden = true
                questionLabel.isHidden = true
                answerTextField.isHidden = true
                submitButton.isHidden = true
            }
            finishLabel.isHidden = true
            redoButton.isHidden = true
            nextButton.isHidden = true
            outcomeLabel.text = ""
        }else{
            headerLabel.isHidden = true
            questionLabel.isHidden = true
            answerTextField.isHidden = true
            outcomeLabel.text = ""
            submitButton.isHidden = true
            nextButton.isHidden = true
            finishLabel.isHidden = false
            redoButton.isHidden = false
        }
    }
    
    
    @IBAction func answerChanged(_ textField: UITextField) {
        curr_ans = Float(textField.text ?? "")
    }
    
    
    @IBAction func submit(_ sender: Any) {
        if (curr_ans != nil), Float(curr_ans)-Float(NumQs[curr_ind].answer) == Float(0) {
            outcomeLabel.text = "CORRECT"
            outcomeLabel.textColor = .green
            NumQStore.numQScore[curr_ind] = 1
        }else{
            outcomeLabel.text = "INCORRECT"
            outcomeLabel.textColor = .red
            NumQStore.numQScore[curr_ind] = -1
        }
        nextButton.isHidden = false
        submitButton.isHidden = true
    }

    
    @IBAction func next(_ sender: Any) {
        curr_ind+=1
        if curr_ind == NumQs.count {
            toggleFinish(toFinish: true)
        }else{
            questionLabel.text = NumQs[curr_ind].question
            outcomeLabel.text = ""
            nextButton.isHidden = true
            submitButton.isHidden = false
            answerTextField.text = ""
        }
    }
    
    
    
    @IBAction func redo(_ sender: UIButton) {
        self.viewDidLoad()
        NumQStore.refreshNumQ()
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
