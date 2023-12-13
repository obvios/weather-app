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
    private var topStackView = UIStackView()
    private var weatherInfoStackView = UIStackView()
    private var weatherIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // build view hierarchy
        setupViews()
        // TODO: tell vm we loaded
    }
    
    private func setupViews() {
        // Configure Text Field
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"

        // Configure Button
        button.setTitle("Press Me", for: .normal)
        // TODO: Add button action
        
        // Configure Top Stack View
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.distribution = .fill
        topStackView.spacing = 8
        topStackView.addArrangedSubview(textField)
        topStackView.addArrangedSubview(button)

        // Configure Labels Stack View
        weatherInfoStackView.axis = .vertical
        weatherInfoStackView.alignment = .fill
        weatherInfoStackView.distribution = .equalSpacing
        weatherInfoStackView.spacing = 8

        // Add sample labels
        for i in 1...5 {
            let label = UILabel()
            label.text = "Label \(i)"
            weatherInfoStackView.addArrangedSubview(label)
        }
    }

    private func observeViewModel() {
        viewModel.uiDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { uiData in
                // TODO: Update UI
            }
    }
}

