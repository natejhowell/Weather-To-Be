//
//  ForecastCell.swift
//  Weather to Be
//
//  Created by Nate Howell on 8/17/21.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var forecastTime: UILabel!
    @IBOutlet weak var forecastTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
