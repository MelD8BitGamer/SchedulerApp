//
//  CreateEventController.swift
//  Scheduler
//
//  Created by Alex Paul on 11/20/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit
//this controller wants to know what sate its in not the model so put it in the model
enum EventState {
  case newEvent
  case existingEvent
}

class CreateEventController: UIViewController {
  
  @IBOutlet weak var eventNameTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var eventButton: UIButton!
  
  public var event: Event?
  
  // private for setting or changing you can only change it here just to look
  // public for getting and reading
  public private(set) var eventState = EventState.newEvent
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set the view controller as the delegate for the text field
    eventNameTextField.delegate = self
        
    updateUI()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //you can put call save function here so when the view disappears it will save automatically
    }
   //it changes the UI so that the button says update event and not create event
  private func updateUI() {
    if let event = event {//coming form an existing event didSelectRowAt
      self.event = event
      datePicker.date = event.date
      eventNameTextField.text = event.name
      eventButton.setTitle("Update Event", for: .normal)
      eventState = .existingEvent
    } else {
      // instantiate a default value for event
      event = Event(date: Date(), name: "") // Date()
        //TODO: change event to force creator to create events for now not the past
      eventState = .newEvent
    }
  }
  
  @IBAction func datePickerChanged(sender: UIDatePicker) {
    // update date of event
    event?.date = sender.date
  }
}

extension CreateEventController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    // dismiss the keyboard
    textField.resignFirstResponder()
    
    // update name of event
    event?.name = textField.text ?? "no event name"
    
    return true
  }
}
