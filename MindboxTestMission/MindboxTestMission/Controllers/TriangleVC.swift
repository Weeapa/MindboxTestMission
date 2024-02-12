//
//  TriangleVC.swift
//  MindboxTestMission
//
//  Created by Калякин Дима  on 11.02.2024.
//

import UIKit

class TriangleVC: UIViewController {
    
    //MARK: - Property
    
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вычислить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let triangleASideTextFiled: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сторона А"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let triangleBSideTextFiled: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сторона B"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let triangleCSideTextFiled: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сторона C"
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
        super .viewDidLoad()
        setupView()
        setupTapGestureRecognizer()
    }
    
    
    //MARK: - Actions
    
    @objc private func calculateButtonTapped() {
        guard let sideAText = triangleASideTextFiled.text, let sideA = Double(sideAText),
              let sideBText = triangleBSideTextFiled.text, let sideB = Double(sideBText),
              let sideCText = triangleCSideTextFiled.text, let sideC = Double(sideCText) else {
            resultLabel.text = "Введите корректные значения для сторон треугольника"
            return
        }
        
        guard sideA > 0, sideB > 0, sideC > 0 else {
            resultLabel.text = "Стороны треугольника должны быть положительными числами"
            return
        }
        // Проверка треугольника
        if sideA + sideB <= sideC || sideA + sideC <= sideB || sideB + sideC <= sideA  {
            resultLabel.text = "Такого треугольника не существует"
            return
        }
        
        let s = (sideA + sideB + sideC) / 2
        let area = sqrt(s * (s - sideA) * (s - sideB) * (s - sideC))
        
        let roundedArea = (area * 10).rounded() / 10
        
        // Проверка на прямоугольность
        let isRightAngled = isRightAngledTriangle(sideA, sideB, sideC)
        
        resultLabel.text = "Площадь треугольника: \(roundedArea)\n\(isRightAngled ? "Треугольник прямоугольный" : "Треугольник не прямоугольный")"
    }

    
    //MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = UIColor(hexFromString: "#D3D3D3")
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(triangleASideTextFiled)
        view.addSubview(triangleBSideTextFiled)
        view.addSubview(triangleCSideTextFiled)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            triangleASideTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            triangleASideTextFiled.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            triangleASideTextFiled.widthAnchor.constraint(equalToConstant: 160),
            
            triangleBSideTextFiled.topAnchor.constraint(equalTo: triangleASideTextFiled.bottomAnchor, constant: 25),
            triangleBSideTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            triangleBSideTextFiled.widthAnchor.constraint(equalToConstant: 160),
            
            triangleCSideTextFiled.topAnchor.constraint(equalTo: triangleBSideTextFiled.bottomAnchor, constant: 25),
            triangleCSideTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            triangleCSideTextFiled.widthAnchor.constraint(equalToConstant: 160),
            
            calculateButton.topAnchor.constraint(equalTo: triangleCSideTextFiled.bottomAnchor, constant: 25),
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
    
    private func isRightAngledTriangle(_ a: Double, _ b: Double, _ c: Double) -> Bool {
        let sides = [a, b, c].sorted()
        return sides[0] * sides[0] + sides[1] * sides[1] == sides[2] * sides[2]
    }
    
    //MARK: - Deinitializer
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
