//
//  CalendarViewController.swift
//  Moneta Studio
//
//  Created by Tony on 2/15/21.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Calendar view"
    }
    
    @IBAction func showCalendar(_ sender: Any) {
        let date = Date()
        let pickerController = CalendarPickerViewController(baseDate: date) { (date) in
            print(date)
        }
        
        present(pickerController, animated: true, completion: nil)
    }
    
}
