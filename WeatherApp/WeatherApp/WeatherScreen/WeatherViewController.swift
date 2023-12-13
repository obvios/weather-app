//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eric Palma on 12/11/23.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    private let viewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // UI Components
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    private var topStackView = UIStackView()
    private var weatherInfoStackView = UIStackView()
    private var weatherIcon = UIImageView()
    private var primaryWeather = UILabel()
    private var weatherDescription = UILabel()
    private var temperature = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // build view hierarchy
        setupViews()
        layoutViews()
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
        
        // configure weather data components
        weatherIcon.image = UIImage(named: "NoImage")
        primaryWeather.text = "--"
        weatherDescription.text = "--"
        temperature.text = "--"

        // Configure Labels Stack View
        weatherInfoStackView.axis = .vertical
        weatherInfoStackView.alignment = .fill
        weatherInfoStackView.distribution = .equalSpacing
        weatherInfoStackView.spacing = 8

        // Add weather labels to stack
        weatherInfoStackView.addArrangedSubview(weatherIcon)
        weatherInfoStackView.addArrangedSubview(primaryWeather)
        weatherInfoStackView.addArrangedSubview(weatherDescription)
        weatherInfoStackView.addArrangedSubview(temperature)
    }
    
    private func layoutViews() {
        // Add stack views to the view
        view.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topStackView)
        view.addSubview(weatherInfoStackView)

        // Constraints for topStackView
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Constraints for labelsStackView
        NSLayoutConstraint.activate([
            weatherInfoStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func observeViewModel() {
        viewModel.uiDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { uiData in
                // TODO: Update UI
            }
    }
}

