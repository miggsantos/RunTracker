//
//  RunLogCell.swift
//  RunTracker
//
//  Created by Miguel Santos on 14/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(run: Run){
        runDurationLbl.text = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToKm(places: 3)) km"
        averagePaceLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.getDateString()
    }
    
}
