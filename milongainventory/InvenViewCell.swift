//
//  InvenViewCell.swift
//  milongainventory
//
//  Created by Jose Alvarez on 9/29/20.
//  Copyright © 2020 josealvarezavina. All rights reserved.
//

import UIKit

class InvenViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.quantityLabel.layer.cornerRadius = 20
        self.sizeLabel.layer.cornerRadius = 20
        self.nameLabel.layer.cornerRadius = 20
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
