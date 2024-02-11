//
//  MainTabBarController.swift
//  MindboxTestMission
//
//  Created by Калякин Дима  on 10.02.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarApperance()
        
    }
    
    private func generateTabBar(){
        viewControllers = [
            generateVC(
                viewController: TriangleVC(),
                title: "Треугольник",
                image: UIImage(systemName: "triangle.fill")),
            generateVC(
                viewController: CircleVC(),
                title: "Круг", image:
                UIImage(systemName: "circle.fill")),
        ]
    }
    
    private func generateVC(viewController:UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        return viewController
    }
    
    private func setTabBarApperance(){
        let positionX: CGFloat = 10
        let positionY: CGFloat = 14
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect:
                                        CGRect(x: positionX,
                                               y: tabBar.bounds.minY -  positionY,
                                               width: width,
                                               height: height),
                                      cornerRadius: height / 2 )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        
        roundLayer.fillColor = UIColor.systemGray.cgColor
        tabBar.tintColor = .white
        
        
        
    }
}

