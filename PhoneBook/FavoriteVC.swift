//
//  FavoriteVC.swift
//  PhoneBook
//
//  Created by Burak Yılmaz on 16.08.2022.
//

import UIKit
import CoreData



class FavoriteVC: UIViewController {
    
    var favPersonList = [FavPerson]()
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet var favTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        
        
        favTableView.delegate = self
        favTableView.dataSource = self
        
    }
    
    
    func getPerson() {
        
        do {
            favPersonList = try context.fetch(FavPerson.fetchRequest())
        } catch  {
            print(error.localizedDescription)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPerson()
        favTableView.reloadData()
    }
    



}

extension FavoriteVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPersonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)  as! FavPersonCell
        let favPerson = favPersonList[indexPath.row]
        cell.nameLabel.text = favPerson.favperson_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favPerson = favPersonList[indexPath.row]
        
        let alert = UIAlertController(title: "\(favPerson.favperson_name!)", message: "\(favPerson.favperson_number!)", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "DONE!", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { UITableViewRowAction, IndexPath in
            let person = self.favPersonList[IndexPath.row]
            self.context.delete(person)
            appDelegate.saveContext()
            self.getPerson()
            self.favTableView.reloadData()
        }
        
        return [delete]
    }
    
}
