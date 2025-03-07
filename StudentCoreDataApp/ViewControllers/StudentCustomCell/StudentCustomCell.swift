//
//  StudentCustomCell.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 06/03/25.
//

import UIKit

class StudentCustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblrollno: UILabel!
    
    @IBOutlet weak var lbldept: UILabel!
    
    @IBOutlet weak var lbladdress: UILabel!
    
    
    @IBOutlet weak var btnRefEdit: UIButton!
    
    @IBOutlet weak var btnRefDelete: UIButton!
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
