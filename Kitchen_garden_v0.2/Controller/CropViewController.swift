//
//  CropViewController.swift
//  Kitchen_garden_v0.2
//
//  Created by Peigeng Jiang on 30/3/19.
//  Copyright © 2019 Peigeng Jiang. All rights reserved.
//

import UIKit
import os.log

class CropViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var cropImage: UIImageView!
    @IBOutlet weak var cropInfo: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var addNewCrop: UIBarButtonItem!
    
    /*
     This value is either passed by 'MealTableViewController' in 'Prepare(for:sender:)'
     or constructed as part of adding a new meal.
     */
    var crop: Crop?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let crop = crop {
            navigationItem.title = crop.name
            ratingControl.rating = crop.rating
            cropImage.image = crop.image
            cropInfo.text = crop.info
            cropInfo.numberOfLines = 6
            cropInfo.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        }
        
    }
    
    //MARK: Navigation
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //better to always have super prepare code below
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === addNewCrop else {
            os_log("The add button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }
    
    //Back function need fix
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
    }
    
    
    //MARK: Action view image in full screen
    @IBAction func displayImage(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
}

