//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let viewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // UI Components
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    private var labelsStackView = UIStackView()
    private var topStackView = UIStackView()
    
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

