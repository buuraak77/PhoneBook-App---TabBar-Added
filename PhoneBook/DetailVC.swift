//
//  DetailVC.swift
//  PhoneBook
//
//  Created by Burak Yılmaz on 11.08.2022.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    var gettingPerson: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let person = gettingPerson {
            nameLabel.text = person.person_name
            numberLabel.text = person.person_number
            imageView.image = UIImage(named: person.person_image!)
        }
        
        
    }
    
    



}
