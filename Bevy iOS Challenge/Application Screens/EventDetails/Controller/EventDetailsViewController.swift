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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapConfigurations()
    }
    
    private func setupData(){
        self.eventNameLabel.text = viewModel.outputs.eventName
        self.eventDescriptionLabel.text = viewModel.outputs.eventDescription
        self.eventDateLabel.text = viewModel.outputs.eventDate
        self.eventImageView.sd_setImage(
            with: viewModel.outputs.eventImageURL,
            placeholderImage: UIImage(systemName: "calendar.circle"))
    }
    
    private func mapConfigurations(){
        let coordinate = CLLocationCoordinate2D(
            latitude: viewModel.outputs.latitude,
            longitude: viewModel.outputs.longitude)
        setRegion(at: coordinate)
        addAnnotation(at: coordinate)
    }
    
    private func setRegion(at coordinate: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.eventLocationMapView.setRegion(region, animated: true)
    }
    
    private func addAnnotation(at coordinate: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = viewModel.outputs.eventName
        annotation.subtitle = viewModel.outputs.eventDate
        eventLocationMapView.addAnnotation(annotation)
    }
}
