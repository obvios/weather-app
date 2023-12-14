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
    // add to stack
    private var locationName = UILabel()
    private var primaryWeather = UILabel()
    private var weatherDescription = UILabel()
    private var temperature = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // build view hierarchy
        setupViews()
        layoutViews()
        observeViewModel()
        viewModel.onViewLoaded()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        // Configure Text Field
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"

        // Configure Button
        button.setTitle("Go", for: .normal)
        button.addTarget(self, action: #selector(searchButtonClicked), for: .touchDown)
        
        // Configure Top Stack View
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.distribution = .fill
        topStackView.spacing = 8
        topStackView.addArrangedSubview(textField)
        topStackView.addArrangedSubview(button)
        
        // configure weather data components
        weatherIcon.image = UIImage(named: "NoImage")
        locationName.text = "--"
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
        weatherInfoStackView.addArrangedSubview(locationName)
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
    
    @objc
    func searchButtonClicked() {
        // get textfield text
        guard let cityName = textField.text else { return }
        // call vm
        viewModel.onUserCitySearch(cityName: cityName)
    }

    private func observeViewModel() {
        viewModel.uiDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiData in
                self?.weatherIcon.image = UIImage(data: uiData.iconData)
                // Instead of setting labels like this by concatenating string, would normally
                // use a horizontal UIStack
                self?.locationName.text = "Location: " + uiData.cityName
                self?.primaryWeather.text = "Weather: " + uiData.weather
                self?.weatherDescription.text = "Description: " + uiData.weatherDescription
                self?.temperature.text = "Temperature: " + String(uiData.temperature) + " Kelvin"
            }.store(in: &cancellables)
    }
}

