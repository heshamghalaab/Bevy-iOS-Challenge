//
//  EventsDelegate.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsDelegate: NSObject, UITableViewDelegate{
    
    let viewModel: EventsViewModelProtocol
    
    init(viewModel: EventsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputs.selectEvent(atRow: indexPath.row)
    }
}
