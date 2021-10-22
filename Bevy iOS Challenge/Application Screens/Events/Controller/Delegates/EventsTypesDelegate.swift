//
//  EventsTypesDelegate.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsTypesDelegate: NSObject, UICollectionViewDelegate{
    
    let viewModel: EventsViewModelProtocol
    
    init(viewModel: EventsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputs.selectEventType(atRow: indexPath.row)
    }
}
