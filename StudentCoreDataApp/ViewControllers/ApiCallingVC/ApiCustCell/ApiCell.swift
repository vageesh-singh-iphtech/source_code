//
//  ApiCell.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 17/03/25.
//

import UIKit

class ApiCell: UITableViewCell {
    
    
    @IBOutlet weak var lbluserID: UILabel!
    
    @IBOutlet weak var lblid: UILabel!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var lblcompleted: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        

    }
}
