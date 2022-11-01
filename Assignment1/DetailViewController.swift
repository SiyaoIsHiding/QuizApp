//
//  DetailViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 27/10/2022.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // MARK: Attributes
    var numQ : NumQ!
    var new: Bool = false
    
    @IBOutlet var questionField: UITextField!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
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
    
    // MARK: - Scene Events
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !new {questionField.text = numQ.question
            answerField.text = numberFormatter.string(from: NSNumber(value: numQ.answer))
            dateLabel.text = dateFormatter.string(from: numQ.date)
        }else{
            dateLabel.text = ""
        }
        
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        if !new{
            numQ.question = questionField.text ?? ""
            if let answer = answerField.text, let value = numberFormatter.number(from: answer){
                numQ.answer = value.floatValue
            }else{
                numQ.answer = 0
            }
        }else{
            let newQuestion = questionField.text ?? ""
            let newAnswer: Float
            if let answer = answerField.text, let value = numberFormatter.number(from: answer){
                newAnswer = value.floatValue
            }else{
                newAnswer = 0
            }
            
            let newNumQ = NumQ(newQuestion, newAnswer)
            NumQStore.createNumQ(numq: newNumQ)
        }
        
    }
    
    // MARK: - Button events
    
    @IBAction func tapBackground(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        print("button clicked")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        // TODO: Question for TA
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
 
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.barButtonItem = sender
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - image picker
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
}
