//
//  WeatherViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 13/5/2565 BE.
//

import UIKit

class WeatherViewController: UIViewController {

    let weatherInfoModalViewController = WeatherInfoModalViewController()
    
    let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
}

extension WeatherViewController {
    
    private func setupConstraints() {
        
        view.addSubview(background)
        view.addSubview(weatherInfoModalViewController)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        weatherInfoModalViewController.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([        background.topAnchor.constraint(equalTo: view.topAnchor),
             background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([        background.topAnchor.constraint(equalTo: view.topAnchor),
             background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
