//
//  ViewController.swift
//  NatikeKitTest
//
//  Created by Paulo Coutinho on 22/08/17.
//  Copyright © 2017 PRSoluções. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nk = NKHttpClient.create()
        let message = nk?.doGet("http://httpbin.org/get")
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

