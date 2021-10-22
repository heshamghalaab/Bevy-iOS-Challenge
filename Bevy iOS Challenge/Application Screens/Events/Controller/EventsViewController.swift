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
    private var eventsTypesDataSource: EventsTypesDataSource!
    private var eventsTypesDelegate: EventsTypesDelegate!
    private var eventsDataSource: EventsDataSource!
    private var eventsDelegate: EventsDelegate!
    private let refreshControl = UIRefreshControl()
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    
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
        eventsDataSource = EventsDataSource(viewModel: viewModel)
        eventsTableView.dataSource = eventsDataSource
        
        eventsDelegate = EventsDelegate(viewModel: viewModel)
        eventsTableView.delegate = eventsDelegate
        
        let nib = UINib(nibName: EventTableViewCell.identifier, bundle: nil)
        eventsTableView.register(nib, forCellReuseIdentifier: EventTableViewCell.identifier)
        eventsTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    /// Binind all changes that could happen in the view model.
    private func binding(){
        viewModel.outputs.showLoading = { [weak self] loading in
            self?.updateLoading(loading)
        }
        
        viewModel.outputs.reloadEventsTypesData = { [weak self] in
            self?.eventsTypesCollectionView.reloadData()
        }
        
        viewModel.outputs.reloadEventsData = { [weak self] in
            self?.eventsTableView.reloadData()
        }
        
        viewModel.outputs.failureAlert = { [weak self] message in
            self?.showAlert(message: message)
        }
    }
    
    private func updateLoading(_ loading: EventsFetchingType?){
        switch loading{
        case .intialize, .refresh:
            LoadingView.show()
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = UIActivityIndicatorView(style: .medium)
            nextPageLoadingSpinner?.frame = CGRect(
                origin: .zero, size: CGSize(width: eventsTableView.frame.width, height: 44))
            nextPageLoadingSpinner?.startAnimating()
            eventsTableView.tableFooterView = nextPageLoadingSpinner
            
        case .none:
            LoadingView.hide()
            eventsTableView.tableFooterView = nil
        }
    }
    
    /// Handling UI
    private func setupUI(){
        self.view.insertDefaultGradientLayer()
        self.addRefreshControl()
    }
    
    private func addRefreshControl(){
        self.refreshControl.tintColor = .white
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.eventsTableView.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.refreshControl.endRefreshing()
        self.viewModel.inputs.getEvents(fetchingType: .refresh)
    }
}
