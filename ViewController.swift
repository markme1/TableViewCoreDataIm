//
//  ViewController.swift
//  TableViewCoreDataIm
//
//  Created by mark me on 3/17/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var array = [User]()
    
    @IBOutlet var tableView: UITableView!

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    func loadData() {
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            array = try context.fetch(request)
            self.tableView.reloadData()
            
        } catch {
            print("Data could not fatched right now")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellClass
        let addImage = array[indexPath.row]
        
        if let cellImage = UIImage(data: addImage.image as! Data) {
            cell.picture?.image = cellImage

        }
        cell.label?.text = addImage.name
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @IBAction func addButton(_ sender: Any)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        self.saveContext(with: image)
    
    }
    func saveContext(with image: UIImage) {
        let newImage = User(context: context)
        newImage.image = NSData(data: image.jpegData(compressionQuality: 0.75)!) as Data
        
        
        let alert = UIAlertController(title: "Item", message: "Add New Item", preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            
            textField.placeholder = "Add New Item"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action: UIAlertAction) in
            
            let nameField = alert.textFields?.first
            if nameField?.text != "" {
                self.context.name = nameField?.text
                
                do {
                    try self.context.save()
                    self.loadData()
                }
                catch {
                    print("Data could not saved right now")
                }
            }
        
        }))
    
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
}

