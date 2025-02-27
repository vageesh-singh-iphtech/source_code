//
//  CustCellFruitInfoTableViewCell.swift
//  ListingDemo
//
//  Created by iPHTech 35 on 25/02/25.
//

import UIKit

class CustCellFruitInfoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var fruitInfo: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
