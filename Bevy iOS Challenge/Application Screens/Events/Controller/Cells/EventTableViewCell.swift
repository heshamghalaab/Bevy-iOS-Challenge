//
//  EventTableViewCell.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: EventViewModelProtocol){
        self.eventNameLabel.text = viewModel.outputs.eventName
        self.eventDescriptionLabel.text = viewModel.outputs.eventDescription
        self.eventDateLabel.text = viewModel.outputs.eventDate
        self.eventImageView.sd_setImage(
            with: viewModel.outputs.eventImageURL,
            placeholderImage: UIImage(systemName: "calendar.circle"))
    }
    
}
