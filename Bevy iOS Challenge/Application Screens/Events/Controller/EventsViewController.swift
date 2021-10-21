//
//  EventsViewController.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var eventsTypesCollectionView: UICollectionView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    // MARK: Properties
    
    var viewModel: EventsViewModelProtocol!
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
