//
//  ViewController.swift
//  Stars
//
//  Created by Stephanie Bowles on 5/10/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var starNameTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var starsTextView: UITextView!
    
    let starController = StarController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listStars()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = starNameTextField.text,  //gotta make sure there's text
            let distanceString = distanceTextField.text,
            let distance = Double(distanceString) else {return}
        
        self.starController.addStar(named: name, withDistance: distance)
        self.listStars()
        self.clearInput()
        
        print("Tapped add Button")
    }
    
    private func listStars(){
        var output = ""
        for star in starController.stars {
            output += "\(star.name) is \(star.distance) light years away. \n"
        }
        starsTextView.text = output
    }
    
    private func clearInput() {
        self.starNameTextField.text = ""
        self.distanceTextField.text = ""
    }
}

