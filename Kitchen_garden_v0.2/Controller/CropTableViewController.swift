//
//  CropTableViewController.swift
//  Kitchen_garden_v0.2
//
//  Created by Peigeng Jiang on 31/3/19.
//  Copyright © 2019 Peigeng Jiang. All rights reserved.
//

import UIKit
import os.log

class CropTableViewController: UITableViewController {
    
    //MARK: Properties
    var crops = [Crop]()
    var userName: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleCrops()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CropTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CropTableViewCell else {
            fatalError("The dequeued cell is not an instance of CropTableViewCell.")
        }

        //Fetches the appropriate crop for the data source layout.
        let crop = crops[indexPath.row]
        
        //Configure the cell
        cell.cropName.text = crop.name
        cell.cropImage.image = crop.image
        cell.cropState.text = crop.state

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            crops.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        os_log("Adding a new crop", log: OSLog.default, type: .debug)
        
        if segue.identifier == "ViewDetail" {
            guard let cropVC = segue.destination as? CropViewController else {
                fatalError("Can't find crop view controller")
            }
            guard let selectedCropCell = sender as? CropTableViewCell else {
                fatalError("Can't find related crop view cell")
            }
            guard let indexPath = tableView.indexPath(for: selectedCropCell) else {
                fatalError("Can't find select row")
            }
            cropVC.navigationItem.rightBarButtonItem = nil
            let crop = crops[indexPath.row]
            cropVC.crop = crop
        }
    }
    
    
    //MARK: Actions
    @IBAction func unwindToCropList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? CropViewController, let crop = sourceViewController.crop {
                //Add a new crop.
                let newIndexPath = IndexPath(row: crops.count, section: 0)
                
                crops.append(crop)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    
    //MARK: Test sample funcion
    private func loadSampleCrops()  {
        //Sample image
        let image1 = UIImage(named: "crop2")
//        let image2 = UIImage(named: "crop3")
//        let image3 = UIImage(named: "crop1")
        
        //Sample text
        let info1:String = "Tips: Provide some shelter from wind. Avoid planting tomatoes where tomatoes, potatoes, chillies or eggplants have been the previous year. Also stake your tomato plants."
//        let info2:String = "Tips: Mulch well to prevent fungal disease and pest invasion - beat the birds to your harvest!"
//        let info3:String = "Tips: Don't harvest after 18 weeks."
        
        guard let crop1 = Crop(name: "Cheery Tomato", info: info1, state: "State: Good", image: image1, rating: 4 ) else {
            fatalError("Unable to instantiate crop1")
        }
//        guard let crop2 = Crop(name: "Strawberries", info: info2, image: image2, rating: 5 ) else {
//            fatalError("Unable to instantiate crop2")
//        }
//        guard let crop3 = Crop(name: "Carrot", info: info3, image: image3, rating: 3 ) else {
//            fatalError("Unable to instantiate crop3")
//        }
        
        crops += [crop1]
    }

}
