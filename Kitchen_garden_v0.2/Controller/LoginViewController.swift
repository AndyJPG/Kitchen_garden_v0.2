//
//  LoginViewController.swift
//  Kitchen_garden_v0.2
//
//  Created by Peigeng Jiang on 1/4/19.
//  Copyright © 2019 Peigeng Jiang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var exploreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userName.delegate = self
        updateExploreButtonState()
    }
    
    //Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide keyborad
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //check if there is text in text field
        updateExploreButtonState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button while editing
        exploreButton.isEnabled = false
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Explore" {
            guard let currentCropsNC = segue.destination as? UINavigationController else {
                fatalError("Can't find navigation controller")
            }
                        
            guard let currentCropsVC = currentCropsNC.viewControllers.first as? CropTableViewController else {
                fatalError("No crop view controller in navigation controller")
            }
            currentCropsVC.userName = userName.text
        }
    }
    
    
    //MARK: Private Methods
    private func updateExploreButtonState() {
        //Disable the Save button if the text field is empty.
        let text = userName.text ?? ""
        exploreButton.isEnabled = !text.isEmpty
    }

}
