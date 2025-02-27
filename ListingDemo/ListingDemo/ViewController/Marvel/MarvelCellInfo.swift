//
//  MarvelCellInfo.swift
//  ListingDemo
//
//  Created by iPHTech 35 on 26/02/25.
//

import UIKit

class MarvelCellInfo: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var power: UILabel!
    @IBOutlet weak var weakness: UILabel!
    @IBOutlet weak var agility: UILabel!
    @IBOutlet weak var xFactor: UILabel!
    
    @IBOutlet weak var submit_btn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        viewContent.layer.cornerRadius  = 5
        viewContent.layer.borderColor = UIColor.blue.cgColor
        viewContent.layer.borderWidth = 3
        viewContent.layer.masksToBounds = true
        
        submit_btn.layer.cornerRadius = 5

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
