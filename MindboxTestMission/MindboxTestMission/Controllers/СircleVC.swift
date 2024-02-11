//
//  СircleVC.swift
//  MindboxTestMission
//
//  Created by Калякин Дима  on 11.02.2024.
//

import UIKit

class CircleVC: UIViewController {
    
    //MARK: - Property
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вычислить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let radiusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Радиус"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTapGestureRecognizer()
    }
    
    
    //MARK: - Actions
    
    @objc private func calculateButtonTapped() {
        guard let radiusText = radiusTextField.text, let radius = Double(radiusText) else {
            resultLabel.text = "Введите корректное значение"
            return
        }
        
        guard radius > 0 else {
            resultLabel.text = "Радиус круга должен быть положительным числом"
            return
        }
        
        let area = Double.pi * radius * radius
        
        let roundedArea = (area * 10).rounded() / 10
        
        resultLabel.text = "Площадь круга: \(roundedArea)"
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = UIColor(hexFromString: "#D3D3D3")
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(radiusTextField)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            radiusTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radiusTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            radiusTextField.widthAnchor.constraint(equalToConstant: 160),
            
            calculateButton.topAnchor.constraint(equalTo: radiusTextField.bottomAnchor, constant: 25),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 160),
            
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 25),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        view.endEditing(true) 
    }
    
    //MARK: - Deinitializer
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
