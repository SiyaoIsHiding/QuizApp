//
//  EditTableViewController.swift
//  Assignment1
//
//  Created by HE Siyao on 24/10/2022.
//

import UIKit

class EditTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NumQCell", for: indexPath) as! NumQCell
        
        let numQ = NumQStore.allNumQ[indexPath.row]
        cell.questionLabel.text = numQ.question
        cell.answerLabel.text = "\(numQ.answer)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumQStore.allNumQ.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            NumQStore.removeNumQ(ind: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        NumQStore.moveNumQ(from: sourceIndexPath.row, to: destinationIndexPath.row)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "openNumQDetail":
            if let row = tableView.indexPathForSelectedRow?.row{
                let numQ = NumQStore.allNumQ[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.numQ = numQ
            }
        default:
            print("Wrong segue Identifier")
        }
    }
    
    
    
    
    
}
