//
//  WeatherViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 13/5/2565 BE.
//

import UIKit

class WeatherViewController: UIViewController {

    let defaultHeight: CGFloat = 400
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    var currentContainerHeight: CGFloat = 300
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
//    let maxDimmedAlpha: CGFloat = 0.6
//    lazy var dimmedView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.alpha = maxDimmedAlpha
//        return view
//    }()
    
    let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupPanGesture()
        
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.18, green: 0.2, blue: 0.353, alpha: 0.8).cgColor,
            UIColor(red: 0.11, green: 0.106, blue: 0.2, alpha: 0.8).cgColor
        ]
        
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.91, b: 1.02, c: -0.95, d: 0.21, tx: 0.5, ty: -0.17))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        containerView.layer.addSublayer(layer0)
        
    }
}

extension WeatherViewController {
    
    private func setupConstraints() {
        
        view.addSubview(background)
//        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        background.translatesAutoresizingMaskIntoConstraints = false
//        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([        background.topAnchor.constraint(equalTo: view.topAnchor),
             background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
//            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
//            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    //MARK -: Action
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        let isDraggingDown = translation.y > 0

        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                
                containerViewHeightConstraint?.constant = newHeight
                
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
}
