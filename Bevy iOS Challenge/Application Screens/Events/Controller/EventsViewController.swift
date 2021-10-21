//
//  EventsViewController.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsViewController: UIViewController, Alertable {

    // MARK: Outlets
    
    @IBOutlet weak var eventsTypesCollectionView: UICollectionView!
    @IBOutlet weak var eventsTableView: UITableView!
    
    // MARK: Properties
    
    var viewModel: EventsViewModelProtocol!
    var eventsTypesDataSource: EventsTypesDataSource!
    var eventsTypesDelegate: EventsTypesDelegate!
    
    
    // MARK: - View controller lifecycle methods

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurations()
        setupUI()
        binding()
        viewModel.inputs.getEventsTypes()
    }
    
    // MARK: - Configuration methods
    
    private func configurations(){
        eventsTypesConfigurations()
        eventsConfigurations()
    }
    
    /// Configurations for events types collection view.
    private func eventsTypesConfigurations(){
        eventsTypesDataSource = EventsTypesDataSource(viewModel: viewModel)
        eventsTypesCollectionView.dataSource = eventsTypesDataSource
        
        eventsTypesDelegate = EventsTypesDelegate(viewModel: viewModel)
        eventsTypesCollectionView.delegate = eventsTypesDelegate
        
        let nib = UINib(nibName: EventTypeCollectionViewCell.identifier, bundle: nil)
        eventsTypesCollectionView.register(
            nib, forCellWithReuseIdentifier: EventTypeCollectionViewCell.identifier)
    }
    
    /// Configurations for events table view.
    private func eventsConfigurations(){
        
    }
    
    /// Binind all changes that could happen in the view model.
    private func binding(){
        viewModel.outputs.showLoading = { [weak self] loading in
            self?.updateLoading(loading)
        }
        
        viewModel.outputs.reloadEventsTypesData = { [weak self] in
            self?.eventsTypesCollectionView.reloadData()
        }
        viewModel.outputs.failureAlert = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    private func updateLoading(_ loading: EventsViewModelLoading?){
        switch loading{
        case .fullScreen: LoadingView.show()
        case .nextPage: break
        case .none: LoadingView.hide()
        }
    }
    
    /// Handling UI
    private func setupUI(){
        self.view.insertDefaultGradientLayer()
    }
}
