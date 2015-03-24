//
//  ViewController.swift
//  WeightLogger
//
//  Created by Annemarie Ketola on 3/23/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataViewControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBAction + Segue
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        println("View controller unwrap to viewcontroller")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this is where you say what is going where
        // if the segue identifier == "dataViewController"
        
        if let dataViewController = segue.destinationViewController as? DataViewController {
            println("ViewController.preparing dataViewController")
            // presets some default properties (weight and time here) or settings
            // from the 1st view controller to the DataViewController
            dataViewController.delegate = self
            dataViewController.weight = 150
//            dateViewController.location = "Cupertino"
            dataViewController.date = NSDate(timeIntervalSinceNow: -60 * 60 * 24 * 3)
        }
        
    }

    // Delegate methods for DataViewControllerDelegate
    func dataViewController(dataViewController: DataViewController, didPickDate date: NSDate, weight: Double, location: String) {
        println("ViewController.dataViewController didPickdate")
        var massFormatter = NSMassFormatter()
        let weightString = massFormatter.stringFromValue(weight, unit: NSMassFormatterUnit.Pound)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let dateString = dateFormatter.stringFromDate(date)
        let locationString = location
        
        textView.text! += "\(dateString) weight: \(weightString) location: \(locationString)\n"
        
        
        
    }
    func dataViewControllerDidCancel(dataViewController: DataViewController) {
        println("ViewController.dataViewController did Cancel")
    }
    

}

