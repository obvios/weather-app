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
    private let searchButton = UIButton(type: .system)
    private var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    private var weatherInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter city"
        return textField
    }()
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
        
        // Add search components to stack view
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)

        // Add weather info components to stack view
        weatherInfoStackView.addArrangedSubview(locationNameLabel)
        weatherInfoStackView.addArrangedSubview(primaryWeatherLabel)
        weatherInfoStackView.addArrangedSubview(weatherDescriptionLabel)
        weatherInfoStackView.addArrangedSubview(temperatureLabel)
    }
    
    private func layoutViews() {
        view.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchStackView)
        view.addSubview(weatherIcon)
        view.addSubview(weatherInfoStackView)

        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            weatherIcon.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 10),
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
        viewModel.searchCityWeather(cityName: cityName)
    }

    private func observeViewModel() {
        viewModel.uiDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiData in
                self?.updateUI(with: uiData)
            }.store(in: &cancellables)
    }
    
    private func updateUI(with weatherData: WeatherScreenUIData) {
        // Instead of setting labels like this by concatenating string, would normally
        // use a horizontal UIStack
        weatherIcon.image = UIImage(data: weatherData.iconData)
        locationNameLabel.text = "Location: " + weatherData.cityName
        primaryWeatherLabel.text = "Weather: " + weatherData.weather
        weatherDescriptionLabel.text = "Description: " + weatherData.weatherDescription
        temperatureLabel.text = "Temperature: " + String(weatherData.temperature) + " Kelvin"
    }
}

