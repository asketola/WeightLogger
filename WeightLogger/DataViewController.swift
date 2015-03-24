//
//  DataViewController.swift
//  WeightLogger
//
//  Created by Annemarie Ketola on 3/23/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

import UIKit

protocol DataViewControllerDelegate {
    // success
    
    func dataViewController(dataViewController: DataViewController, didPickDate date: NSDate, weight: Double, location: String)
    
    // cancel
    func dataViewControllerDidCancel(dataViewController: DataViewController)
    
    }

class DataViewController: UIViewController {
    
    var weight: Double? {
        didSet {
        updateUI()
        }
    }
    
    var date: NSDate? {
        didSet {
        updateUI()
        }
    }
    
    var location: String? {
        didSet {
        updateUI()
        }
    }
    
    var locationsForPicker = ["Mountain View", "Sunnyvale", "Cupertino", "Santa Clara", "San Jose"]
    
    var delegate: DataViewControllerDelegate?

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationPicker: UIPickerView!
    
    
    func updateUI() {
        if let weight = weight {
            weightTextField?.text = "\(weight)"
        }
        
        if let date = date {
            datePicker?.date = date
        }
        
        if let location = location {
            locationPicker?.text = "\(location)"
        }
    } // closes updateUI function
    
    // Protocols for the UIPickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponents component: Int) -> Int {
        return locationsForPicker.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return locationsForPicker[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("DataViewController.viewDidLoad")
        updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    // Exit segue - must name them!!!!!
        
        if let dataViewController = segue.destinationViewController as? ViewController {
            
            let location = locationPicker.description
            let date = datePicker.date
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            if let weight = numberFormatter.numberFromString(weightTextField.text)?.doubleValue {
                delegate?.dataViewController(self, didPickDate: date, weight: weight, location: location)
        } else {
        delegate?.dataViewControllerDidCancel(self)
            }
        }
    }
}
