//
//  ViewController.swift
//  Calculator
//
//  Created by Gamze Akyüz on 4.08.2024.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    let label = UILabel()
    
    private var isFinishedTypingNumber: Bool = true
       
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.displayLabel.addGestureRecognizer(swipeRight)
        displayLabel.isUserInteractionEnabled = true
        
    }
    @objc func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        if let label = gesture.view as? UILabel, var text = displayLabel.text, !text.isEmpty {
            text.removeLast()  // Son karakteri sil
            displayLabel.text = text  // Güncellenmiş metni label'a ayarla
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                
                if numValue == "." {
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
        
        
        
        
    }
    
    

}

