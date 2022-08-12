//
//  UpdateVC.swift
//  PhoneBook
//
//  Created by Burak Yılmaz on 11.08.2022.
//

import UIKit
import CoreData

class UpdateVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    var gettingPerson: Person?
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
    }

    @IBAction func updateClicked(_ sender: Any) {
        
        if let person = gettingPerson, let name = nameTextField.text, let number = numberTextField.text {
            person.person_number = number
            person.person_name = name
            appDelegate.saveContext()
        }
        
        let alert = UIAlertController(title: "Updated Succesfully", message: "\(nameTextField.text!) Succesfully Updated", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true)

            
            
        }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpdateVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
        
        
        
        
    }
    

