//
//  CustomSegmentedController.swift
//  WordUp
//
//  Created by Alex Wymer on 2018-07-08.
//  Copyright © 2018 Sav Inc. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegmentedController: UIControl {
    
    var buttonsArray = [UIButton]()
    var selector = UIView()
    var selectedSegmentIndex = 0
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {self.layer.borderWidth = borderWidth}
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {self.layer.borderColor = borderColor.cgColor}
    }

    @IBInspectable var commaSeperatedButtonTitles: String = "" {
        didSet {updateView()}
    }
    
    @IBInspectable var buttonTextColor: UIColor = .lightGray {
        didSet {updateView()}
    }
    
    @IBInspectable var buttonSelectedTextColor: UIColor = .darkGray {
        didSet {updateView()}
    }
    
    @IBInspectable var selectorColor: UIColor = .darkGray {
        didSet {updateView()}
    }
    
    func updateView() {
        
        buttonsArray.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        
        for title in buttonTitles {
            
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(buttonTextColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttonsArray.append(button)
        }
        
        buttonsArray[0].setTitleColor(buttonSelectedTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttonsArray.count)
        
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttonsArray)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
   
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        
        updateView()
    }
    
    @objc func buttonTapped(button: UIButton) {
        
        for (buttonIndex, btn) in buttonsArray.enumerated() {
            
            btn.setTitleColor(buttonTextColor, for: .normal)
            
            if btn == button {
                
                selectedSegmentIndex = buttonIndex
                
                let selectorStartPosition = frame.width / CGFloat(buttonsArray.count) * CGFloat(buttonIndex)
                
                UIView.animate(withDuration: 0.3) {
                    
                    self.selector.frame.origin.x = selectorStartPosition
                }
                    
                btn.setTitleColor(buttonSelectedTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }
}
