//
//  EventTypeCollectionViewCell.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
    }

    func configure(with viewModel: EventTypeViewModelProtocol){
        eventTypeLabel.text = viewModel.outputs.eventTypeText
    }
    
    var isTheSelectedType: Bool? {
        didSet{
            if let isTheSelected = isTheSelectedType, isTheSelected {
                contentView.backgroundColor = .systemBlue
                eventTypeLabel.textColor = .white
                eventTypeLabel.font = .boldSystemFont(ofSize: 17)
            }else{
                contentView.backgroundColor = .white
                eventTypeLabel.textColor = .black
                eventTypeLabel.font = .systemFont(ofSize: 15)
            }
        }
    }
}
