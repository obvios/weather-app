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
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter city"
        return textField
    }()
    private let searchButton = UIButton(type: .system)
    private var topStackView = UIStackView()
    private var weatherInfoStackView = UIStackView()
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoImage")
        return imageView
    }()
    private var locationNameLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        return label
    }()
    private var primaryWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        return label
    }()
    private var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        return label
    }()
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        return label
    }()
    
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

        // Configure Button
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchDown)
        
        // Configure Top Stack View
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.distribution = .fill
        topStackView.spacing = 8
        topStackView.addArrangedSubview(searchTextField)
        topStackView.addArrangedSubview(searchButton)

        // Configure Labels Stack View
        weatherInfoStackView.axis = .vertical
        weatherInfoStackView.alignment = .fill
        weatherInfoStackView.distribution = .equalSpacing
        weatherInfoStackView.spacing = 8
        weatherInfoStackView.addArrangedSubview(locationNameLabel)
        weatherInfoStackView.addArrangedSubview(primaryWeatherLabel)
        weatherInfoStackView.addArrangedSubview(weatherDescriptionLabel)
        weatherInfoStackView.addArrangedSubview(temperatureLabel)
    }
    
    private func layoutViews() {
        // Add stack views to the view
        view.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topStackView)
        view.addSubview(weatherIcon)
        view.addSubview(weatherInfoStackView)

        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            weatherIcon.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherInfoStackView.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 20),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc
    func searchButtonClicked() {
        // get textfield text
        guard let cityName = searchTextField.text else { return }
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
                self?.locationNameLabel.text = "Location: " + uiData.cityName
                self?.primaryWeatherLabel.text = "Weather: " + uiData.weather
                self?.weatherDescriptionLabel.text = "Description: " + uiData.weatherDescription
                self?.temperatureLabel.text = "Temperature: " + String(uiData.temperature) + " Kelvin"
            }.store(in: &cancellables)
    }
}

