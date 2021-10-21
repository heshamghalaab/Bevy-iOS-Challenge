//
//  EventsTypesDataSource.swift
//  Bevy iOS Challenge
//
//  Created by Ghalaab on 21/10/2021.
//

import UIKit

class EventsTypesDataSource: NSObject, UICollectionViewDataSource{
    
    let viewModel: EventsViewModelProtocol
    
    init(viewModel: EventsViewModelProtocol) {
        self.viewModel = viewModel
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputs.numberOfEventsTypes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventTypeCollectionViewCell.identifier, for: indexPath) as! EventTypeCollectionViewCell
        let typeViewModel = viewModel.inputs.eventTypeViewModel(atRow: indexPath.row)
        cell.configure(with: typeViewModel)
        cell.isTheSelectedType = viewModel.inputs.isTheSelectEventType(atRow: indexPath.row)
        return cell
    }
}
