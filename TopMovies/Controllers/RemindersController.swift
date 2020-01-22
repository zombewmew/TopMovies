//
//  RemindersController.swift
//  TopMovies
//
//  Created by christina on 21.01.2020.
//  Copyright © 2020 Christina S. All rights reserved.
//

import UIKit
import EventKit

class RemindersController: UIViewController {
    var titleMovie: String?
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var DataPicker: UIDatePicker!
    @IBOutlet weak var movieImageView: UIImageView! // not ready
    
    
    @IBAction func SetReminder(_ sender: UIButton) {
        let s = EKEventStore.init()
        s.requestAccess(to: EKEntityType.reminder) { (comp, e) -> Void in
            let r = EKReminder.init(eventStore: s)
            r.title = "Movie \(self.titleMovie!) just started!"
            let d = NSDate.init().addingTimeInterval(60)
            let a = EKAlarm.init(absoluteDate: d as Date)
            r.calendar = s.defaultCalendarForNewReminders()
            r.addAlarm(a)
            do{
                try s.save(r, commit: true)
                print(r, "Reminder saved.")
            } catch {
                print("Error, not save")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitleLabel.text = titleMovie
        
    }
}
