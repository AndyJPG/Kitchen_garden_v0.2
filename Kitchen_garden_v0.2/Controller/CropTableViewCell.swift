//
//  CropTableViewCell.swift
//  Kitchen_garden_v0.2
//
//  Created by Peigeng Jiang on 31/3/19.
//  Copyright © 2019 Peigeng Jiang. All rights reserved.
//

import UIKit

class CropTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var cropImage: UIImageView!
    @IBOutlet weak var cropName: UILabel!
    @IBOutlet weak var cropState: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
