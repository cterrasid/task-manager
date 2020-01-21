//
//  ViewController.swift
//  TaskManager
//
//  Created by Clarette Terrasi on 07/01/2020.
//  Copyright © 2020 Clarette Terrasi Díaz. All rights reserved.
//

import UIKit

//MARK: 1. Empty array to register the tasks
var tasks = [String]()

class ViewController: UIViewController, UITableViewDataSource {
    // MARK: 2. Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: 3. Actions
    @IBAction func addTask(_ sender: Any) {
        //Crear el UIAlertController, un alert para añadir las tareas que aparecerán en la tabla
        let alert = UIAlertController (title: "New task", message: "Add a new task", preferredStyle: .alert)
        
        // Crear el UIAlertAction, una acción para el alert que permitirá guardar la tarea
        let saveTask = UIAlertAction (title: "Save", style: .default, handler: { (action: UIAlertAction) -> Void in
            // Guardar el texto del textField en el array de tareas y recargar la tableView
            let textField = alert.textFields!.first
            textField?.placeholder = "Enter new task"
            tasks.append(textField!.text!)

            
            // Hacer que la tabla se actualice sola cada vez que se introduce una tarea
            self.tableView.reloadData()
        })
        
        // Crear el UIAlertAction, para cancelar
        let cancelTask = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) -> Void in
        }
        
        // Añadir un textField al alert
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        // Añadir las acciones de Save y Cancel al alert
        alert.addAction(saveTask)
        alert.addAction(cancelTask)
        
        // Lanzar el alert
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: 4. Register an id to the table cells
        // Inicializador de cada celda
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: 5. UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Devuelve la cantidad de filas que tendrá la tabla, es decir, la longitud del array de tareas
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeueing para reutiizar las celdas (performance)
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell")

        // Establecer que el contenido de cada celda, será lo que tenga en cada elemento del array de tareas
        cell!.textLabel!.text = tasks[indexPath.row]

        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

