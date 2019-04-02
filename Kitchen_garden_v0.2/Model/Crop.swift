//
//  Crop.swift
//  Kitchen_garden_v0.2
//
//  Created by Peigeng Jiang on 31/3/19.
//  Copyright © 2019 Peigeng Jiang. All rights reserved.
//

import UIKit

class Crop {
    
    //MARK: Properties
    let name: String
    let info: String
    let image: UIImage?
    let state: String?
    let rating: Int
    
    //MARK: Initialization
    init?(name: String, info: String, state:String?, image: UIImage?, rating: Int){
        //The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        //The info must not be empty
        guard !info.isEmpty else {
            return nil
        }
        //The rating must be correct
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.info = info
        self.image = image
        self.state = state
        self.rating = rating
    }
    
}
