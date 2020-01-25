//
//  ViewController.swift
//  PricePrediction
//
//  Created by Thai Nguyen on 1/22/20.
//  Copyright © 2020 Thai Nguyen. All rights reserved.
//

import UIKit
import LBTATools

class ViewController: UIViewController {
    
    let scrollView: UIScrollView = {
       return UIScrollView()
    }()
    
    let stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        
        return sv
    }()
    
    let roomsLabel = UILabel(text: "Number of Rooms", textAlignment: .left, numberOfLines: 1)
    
    let bathroomsLabel = UILabel(text: "Number of Bathrooms", textAlignment: .left, numberOfLines: 1)
    
    let garageLabel = UILabel(text: "Garage Capacity", textAlignment: .left, numberOfLines: 1)
    
    let yearLabel = UILabel(text: "Year Built", textAlignment: .left, numberOfLines: 1)
    
    let sizeLabel = UILabel(text: "Size", textAlignment: .left, numberOfLines: 1)
    
    let conditionLabel = UILabel(text: "Condition", textAlignment: .left, numberOfLines: 1)
    
    let estimatedLabel = UILabel(text: "Estimated Value", textAlignment: .center, numberOfLines: 1)
    
    let result = UILabel(text: "Label", font: .systemFont(ofSize: 48, weight: .bold), textAlignment: .center, numberOfLines: 1)
    
    lazy var numberOfRooms: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["1", "2", "3", "4", "5"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(updatePrediction), for: .valueChanged)
        return sc
    }()
    
    lazy var numberOfBathrooms: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["1", "2", "3", "4", "5"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(updatePrediction), for: .valueChanged)
        return sc
    }()
    
    lazy var garageCapacity: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["0", "1", "2"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(updatePrediction), for: .valueChanged)
        return sc
    }()
    
    lazy var condition: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["Poor", "Fair", "Average", "Good", "Perfect"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(updatePrediction), for: .valueChanged)
        return sc
    }()
    
    lazy var yearBuiltSlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 1950
        slider.maximumValue = 2018
        slider.setValue(2000, animated: false)
        slider.addTarget(self, action: #selector(updatePrediction), for: .valueChanged)
        return slider
    }()
    
    
    lazy var sizeSlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 400
        slider.maximumValue = 5000
        slider.setValue(2000, animated: false)
        slider.addTarget(self, action: #selector(updatePrediction), for: .valueChanged)
        return slider
    }()
    
    
    @objc func updatePrediction(_ sender: Any) {
        // 1
        yearLabel.text = "Year Built: \(Int(yearBuiltSlider.value))"
        sizeLabel.text = "Size: \(Int(sizeSlider.value))"
        
        do {
            // 2
            let prediction = try model.prediction(
                bathrooms: Double(numberOfBathrooms.selectedSegmentIndex + 1),
                cars: Double(garageCapacity.selectedSegmentIndex),
                condition: Double(condition.selectedSegmentIndex),
                rooms: Double(numberOfRooms.selectedSegmentIndex + 1),
                size: Double(Int(sizeSlider.value)),
                yearBuilt: Double(Int(yearBuiltSlider.value))
            )
            // 3
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            result.text = formatter.string(from: prediction.value as NSNumber) ?? ""
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    let model = HousePrices()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        title = "Price Prediction"
        
        setupViews()
        
        updatePrediction(self)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        let spacing: CGFloat = 30
        
        stackView.addArrangedSubview(roomsLabel)
        stackView.addArrangedSubview(numberOfRooms)
        stackView.setCustomSpacing(spacing, after: numberOfRooms)
        
        stackView.addArrangedSubview(bathroomsLabel)
        stackView.addArrangedSubview(numberOfBathrooms)
        stackView.setCustomSpacing(spacing, after: numberOfBathrooms)
        
        stackView.addArrangedSubview(garageLabel)
        stackView.addArrangedSubview(garageCapacity)
        stackView.setCustomSpacing(spacing, after: garageCapacity)
        
        stackView.addArrangedSubview(yearLabel)
        stackView.addArrangedSubview(yearBuiltSlider)
        stackView.setCustomSpacing(spacing, after: yearBuiltSlider)
        
        stackView.addArrangedSubview(sizeLabel)
        stackView.addArrangedSubview(sizeSlider)
        stackView.setCustomSpacing(spacing, after: sizeSlider)
        
        stackView.addArrangedSubview(conditionLabel)
        stackView.addArrangedSubview(condition)
        stackView.setCustomSpacing(spacing, after: condition)
        
        stackView.addArrangedSubview(estimatedLabel)
        stackView.addArrangedSubview(result)
        
        scrollView.addSubview(stackView)
        
        stackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
    }

}

