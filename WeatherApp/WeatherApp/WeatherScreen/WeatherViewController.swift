//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    let viewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // build view hierarchy
        // tell vm we loaded
    }

    private func observeViewModel() {
        viewModel.uiDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { uiData in
                // TODO: Update UI
            }
    }
}

