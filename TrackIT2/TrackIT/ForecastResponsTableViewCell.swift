//
//  ForecastResponsTableViewCell.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-07-17.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import SnapKit

class ForecastResponseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var forecastWrapperView: UIView!
    
    let numberOfDay = 5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 16
        iconImageView.layer.masksToBounds = true
        
        labelContainerView.layer.cornerRadius = 8
        labelContainerView.layer.masksToBounds = true
        
        labelContainerView.backgroundColor = .clear
        labelContainerView.layer.borderColor = UIColor.blueBorder.cgColor
        labelContainerView.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with message: Message) {
        
        //general
     
        let dateFormatterMessage = DateFormatter()
        dateFormatterMessage.setLocalizedDateFormatFromTemplate("hh:mm")
        timeLabel.text = dateFormatterMessage.string(from: message.date)
        timeLabel.textColor = .grey300
        
        ///header
        
        let dateFormatterHeader = DateFormatter()
        dateFormatterHeader.setLocalizedDateFormatFromTemplate("MMMM dd yyyy")
        
        dateLabel.font = dateLabel.font.withSize(12)
        
        let sepView = UIView()
        sepView.backgroundColor = UIColor.blueBorder.withAlphaComponent(0.5)
        labelContainerView.addSubview(sepView)
        sepView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(labelContainerView)
            make.left.equalTo(labelContainerView)
            make.height.equalTo(1)
            make.bottom.equalTo(forecastWrapperView.snp.top)
        }
        
        //forecast Days
      
    }
    
}
