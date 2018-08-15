//
//  ViewController.swift
//  DecoderEncoderLearning
//
//  Created by mac on 5/24/1397 AP.
//  Copyright © 1397 AkshiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let file = Bundle.main.path(forResource: "Data", ofType: "json") else {return}
        
        do {
            // Read json data from file
            let data = try Data(contentsOf: URL(fileURLWithPath:  file), options: .mappedIfSafe)
            
            // Decode the json data into person (our model)
            let person = try JSONDecoder().decode(Person.self, from: data)
            
            //print(person) // Person(name: "Jacob", age: 25, work_Location: "California")
            
            let encodedData = try PropertyListEncoder().encode(person) // Encode data using property list encodeer
            
            UserDefaults.standard.setValue(encodedData, forKey: "personData")// save data to user defaults
            
        } catch let error {
            print(error)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            let person = try PropertyListDecoder().decode(Person.self, from: UserDefaults.standard.data(forKey: "personData")!)
            print("Encoded person ", person) // Encoded person  Person(name: "Jacob", age: 25, work_Location: "California")
        } catch let error {
            print(error)
        }
        
        
    }
    
    
}



struct Person: Codable {
    var name: String
    var age: Int
    var work_Location: String
}


