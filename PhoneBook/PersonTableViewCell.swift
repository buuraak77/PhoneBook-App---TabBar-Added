//
//  PersonTableViewCell.swift
//  PhoneBook
//
//  Created by Burak Yılmaz on 11.08.2022.
//

import UIKit

protocol DetailButtonTapped {
    func detailTapped(indexPath: IndexPath)
}

class PersonTableViewCell: UITableViewCell {
    
    var personProtocol: DetailButtonTapped?
    var indexPath: IndexPath?

    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var personLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func detailClicked(_ sender: Any) {
        
        personProtocol?.detailTapped(indexPath: indexPath!)
        
    }
    
}
