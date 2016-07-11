//
//  ViewController.swift
//  Test
//
//  Created by Vijay on 7/6/16.
//  Copyright © 2016 Vijay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    typealias AlertCompletion = (buttonTitle: String, buttonIndex: Int) -> Void
    	var alertCompletionBlocks: [UIAlertView: AlertCompletion] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Alert Helpers -
    
    func displayAlert(title title: String, message: String, buttons: [String], completion: AlertCompletion? = nil) {
        let alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: nil)
        
        for title in buttons {
            alert.addButtonWithTitle(title)
        }
        
        alertCompletionBlocks[alert] = completion
        
        alert.show()
    }
    

}














