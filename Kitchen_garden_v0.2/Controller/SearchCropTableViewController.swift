//
//  SearchCropTableViewController.swift
//  Kitchen_garden_v0.2
//
//  Created by Peigeng Jiang on 1/4/19.
//  Copyright © 2019 Peigeng Jiang. All rights reserved.
//

import UIKit
import os.log

class SearchCropTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    var crops = [Crop]()
    var filtered = [Crop]()
    @IBOutlet weak var cropSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleCrops()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //Set up delegate
        cropSearchBar.delegate = self
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchedCropTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchCropTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchCropTableViewCell")
        }
        
        //Fetches the appropriate crop for the data source layout.
        let crop = crops[indexPath.row]

        // Configure the cell
        cell.searchCropName.text = crop.name
        cell.searchCropImage.image = crop.image
        cell.ratingControl.rating = crop.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        super.prepare(for: segue, sender: sender)
        print("segue perfrom")
        print("\(segue.destination)")
        
        if segue.destination is CropViewController {
            print("yes")
            guard let cropViewController = segue.destination as? CropViewController else {
                fatalError()
            }
            guard let selectCropCell = sender as? SearchCropTableViewCell else {
                fatalError()
            }
            guard let indexPath = tableView.indexPath(for: selectCropCell) else {
                fatalError()
            }
            let selectedCrop = crops[indexPath.row]
            cropViewController.crop = selectedCrop
        }
        
    }
    
    //Cancel add item
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    //MARK: Test sample function
    private func loadSampleCrops() {
        //Sample image
        let image1 = UIImage(named: "crop2")
        let image2 = UIImage(named: "crop3")
        let image3 = UIImage(named: "crop1")
        
        //Sample text
        let info1:String = "Tips: Provide some shelter from wind. Avoid planting tomatoes where tomatoes, potatoes, chillies or eggplants have been the previous year. Also stake your tomato plants."
        let info2:String = "Tips: Mulch well to prevent fungal disease and pest invasion - beat the birds to your harvest!"
        let info3:String = "Tips: Don't harvest after 18 weeks."
        
        guard let crop1 = Crop(name: "Cheery Tomato", info: info1, state: "State: Good", image: image1, rating: 4 ) else {
            fatalError("Unable to instantiate crop1")
        }
        guard let crop2 = Crop(name: "Strawberries", info: info2, state: "State: Bad", image: image2, rating: 5 ) else {
            fatalError("Unable to instantiate crop2")
        }
        guard let crop3 = Crop(name: "Carrot", info: info3, state: "State: Poor", image: image3, rating: 3 ) else {
            fatalError("Unable to instantiate crop3")
        }
        
        crops += [crop1, crop2, crop3]
    }

}
