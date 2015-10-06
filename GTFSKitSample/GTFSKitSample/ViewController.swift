//
//  ViewController.swift
//  GTFSKitSample
//
//  Created by Jack Wilsdon on 05/10/2015.
//  Copyright © 2015 Jack Wilsdon. All rights reserved.
//

import UIKit

import GTFSKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let parser = CSVParser(lines: ["agency_name,agency_url,agency_timezone", "a,b,c", "1,2,3"])
        let agencies = parser.parse(Agency)
        
        print(agencies)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

