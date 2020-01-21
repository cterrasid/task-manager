//
//  ViewController.swift
//  TaskManager
//
//  Created by Clarette Terrasi on 07/01/2020.
//  Copyright © 2020 Clarette Terrasi Díaz. All rights reserved.
//

import UIKit
import CoreData

var tasks = [NSManagedObject]()

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Actions
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController (title: "New task", message: "Add a new task", preferredStyle: .alert)
        let saveTask = UIAlertAction (title: "Save", style: .default, handler: { (action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            textField?.placeholder = "Enter new task"
            self.saveTask(nameTask: textField!.text!)

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
    
    func saveTask(nameTask: String) {
        //1 Recuperar el Managed Object Context a partir del appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 Crear un objeto de tipo NSEntityDescription que representa a Task y servira de referencia para el Managed Object Context
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        let task = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        //3
        task.setValue(nameTask, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            tasks.append(task)
        } catch let error as NSError {
            print("Can't save the task \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
        
        // 3
        do {
            let results = try managedContext.fetch(fetchRequest)
            tasks = results as [NSManagedObject]
        } catch let error as NSError {
            print("Can't be loaded \(error), \(error.userInfo)")
        }
        // 4
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell")
        let task = tasks[indexPath.row]
        cell!.textLabel!.text = task.value(forKey: "name") as? String

        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

