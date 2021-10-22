//
//  EventDetailsViewController.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 22/10/2021.
//

import UIKit
import MapKit

class EventDetailsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationMapView: MKMapView!
    
    // MARK: Properties
    
    var viewModel: EventDetailsViewModelProtocol!
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    func setupData(){
        self.eventNameLabel.text = viewModel.outputs.eventName
        self.eventDescriptionLabel.text = viewModel.outputs.eventDescription
        self.eventDateLabel.text = viewModel.outputs.eventDate
        self.eventImageView.sd_setImage(
            with: viewModel.outputs.eventImageURL,
            placeholderImage: UIImage(systemName: "calendar.circle"))
    }
}
