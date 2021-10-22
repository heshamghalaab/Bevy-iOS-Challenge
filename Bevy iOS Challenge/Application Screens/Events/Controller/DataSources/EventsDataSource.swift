//
//  EventsDataSource.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsDataSource: NSObject, UITableViewDataSource{
    
    let viewModel: EventsViewModelProtocol
    
    init(viewModel: EventsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.outputs.numberOfEvents
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        let eventViewModel = viewModel.inputs.eventViewModel(atRow: indexPath.row)
        cell.configure(with: eventViewModel)
        
        viewModel.inputs.nextEventsIfNeeded(at: indexPath.row)
        return cell
    }
}
