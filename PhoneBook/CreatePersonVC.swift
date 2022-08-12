//
//  CreatePersonVC.swift
//  PhoneBook
//
//  Created by Burak Yılmaz on 11.08.2022.
//

import UIKit

class CreatePersonVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
                
        
        if let name = nameTextField.text, let number = numberTextField.text {
            let person = Person(context: context)
            person.person_name = name
            person.person_number = number
            appDelegate.saveContext()
            
            let alert = UIAlertController(title: "DONE!", message: "\(name) Saved Succesfully", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
        
    }
    
    @IBAction func openImagePicker(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        if let img = info[.editedImage] as? UIImage {
            self.imageView.image = img
            
            
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreatePersonVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
            
    }


