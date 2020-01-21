//
//  ViewController.swift
//  TaskManager
//
//  Created by Clarette Terrasi on 07/01/2020.
//  Copyright © 2020 Clarette Terrasi Díaz. All rights reserved.
//

import UIKit

var tasks = [String]()

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Actions
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController (title: "New task", message: "Add a new task", preferredStyle: .alert)
        let saveTask = UIAlertAction (title: "Save", style: .default, handler: { (action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            textField?.placeholder = "Enter new task"
            tasks.append(textField!.text!)

            self.tableView.reloadData()
        })
        
        let cancelTask = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        alert.addAction(saveTask)
        alert.addAction(cancelTask)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell")
        cell!.textLabel!.text = tasks[indexPath.row]

        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

