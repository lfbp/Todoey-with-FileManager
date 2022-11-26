//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {
    var itemArray = [Item]()
    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    override func viewDidLoad() {
        super.viewDidLoad()
        filePath?.appendPathComponent("Item.plist")
        loadData()
    }

    @IBAction func addItemAction(_ sender: Any) {
        var saveTextField = UITextField()
        
        let alertVC = UIAlertController(title: "Add New Todoey Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default, handler: {
            action in
            let item = Item(title: saveTextField.text ?? "", done: false)
            self.itemArray.append(item)
            self.saveData()
            self.tableView.reloadData()
        })
        alertVC.addAction(action)

        alertVC.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "type a new item..."
            saveTextField = textField
        })
        
        present(alertVC, animated: true, completion: nil)
    }
    
    private func saveData() {
        let encoder = PropertyListEncoder()
        do {
            let encoded = try encoder.encode(itemArray)
            try encoded.write(to: filePath!)
        } catch {
            print("Error trying to encode \(error)")
        }
    }
    
    private func loadData() {
        do {
            let data = try Data(contentsOf: filePath!)
            let decoder = PropertyListDecoder()
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Decoding error \(error)")
        }
    }
}

// MARK: - TableView methods
extension TodoeyViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark: .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveData()
        tableView.reloadData()
    }
}
