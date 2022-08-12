//
//  ViewController.swift
//  PhoneBook
//
//  Created by Burak Yılmaz on 11.08.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate


class ViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    
    var selectedPerson: Person?
    
    var personList = [Person]()
    
    

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        getPerson()
        tableView.reloadData()
    }
    
    
    func getPerson() {
        
        do {
            personList = try context.fetch(Person.fetchRequest())
        } catch  {
            print(error.localizedDescription)
        }
        
        
    }
    
    func searchPerson(person_name:String) {
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "person_name CONTAINS %@", person_name)
        
        do {
            personList = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    



    override func viewWillAppear(_ animated: Bool) {
        getPerson()
        tableView.reloadData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {return}
        
        if segue.identifier == "toUpdateVC" {
            let vc = segue.destination as! UpdateVC
            vc.gettingPerson = personList[indexPath.row]
        }

    }
     
}


extension ViewController: UITableViewDelegate, UITableViewDataSource, DetailButtonTapped {
    func detailTapped(indexPath: IndexPath) {
        
        let comingPerson = personList[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        vc.gettingPerson = comingPerson
        self.present(vc, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonTableViewCell
        let person = personList[indexPath.row]
        cell.personLabel.text = person.person_name
        cell.personImageView.image = UIImage(named: "select.png")
        cell.personProtocol = self
        cell.indexPath = indexPath
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { UITableViewRowAction, IndexPath in
            let person = self.personList[IndexPath.row]
            self.context.delete(person)
            appDelegate.saveContext()
            self.getPerson()
            self.tableView.reloadData()
        }

        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toUpdateVC", sender: IndexPath.self)
        
    }
    
}




extension ViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            getPerson()
        }else {
            searchPerson(person_name: searchText)
        }
        
        tableView.reloadData()
    }
    
}
