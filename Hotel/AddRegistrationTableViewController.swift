//
//  AddRegistrationTableViewController.swift
//  Hotel
//
//  Created by Timur Saidov on 21/10/2018.
//  Copyright © 2018 Timur Saidov. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var arrivalDate: UILabel!
    @IBOutlet weak var arrivalDatePicker: UIDatePicker!
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var departureDatePicker: UIDatePicker!
    
    let arrivalDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let departureDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    var isArrivalDatePickerShown: Bool = false {
        didSet {
            arrivalDatePicker.isHidden = !isArrivalDatePickerShown
        }
    }
    var isDepartureDatePickerShown: Bool = false {
        didSet {
            departureDatePicker.isHidden = !isDepartureDatePickerShown
        }
    }
    
    @IBOutlet weak var adultsCount: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var childrenCount: UILabel!
    @IBOutlet weak var childrenStepper: UIStepper!
    
    var adultsCountInt = 0
    var childrenCountInt = 0
    var senderValueAdults = 0
    var senderValueChildren = 0
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    var wifi: Bool = false
    
    @IBAction func updateDate(_ sender: UIDatePicker) {
        updateDate()
    }
    
    @IBAction func countStepper(_ sender: UIStepper) {
        if sender == adultsStepper {
            if Int(sender.value) == senderValueAdults + 1 {
                senderValueAdults += 1
                adultsCountInt += 1
                adultsCount.text = String(adultsCountInt)
            } else if Int(sender.value) == senderValueAdults - 1 {
                senderValueAdults -= 1
                adultsCountInt -= 1
                adultsCount.text = String(adultsCountInt)
            }
        } else if sender == childrenStepper {
            if Int(sender.value) == senderValueChildren + 1 {
                senderValueChildren += 1
                childrenCountInt += 1
                childrenCount.text = String(childrenCountInt)
            } else if Int(sender.value) == senderValueChildren - 1 {
                senderValueChildren -= 1
                childrenCountInt -= 1
                childrenCount.text = String(childrenCountInt)
            }
        }
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            wifi = true
        } else {
            wifi = false
        }
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text else {
            return
        }
        
        print(firstName, lastName, email, arrivalDatePicker.date, departureDatePicker.date, adultsCountInt, childrenCountInt, wifi)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        arrivalDatePicker.minimumDate = midnightToday
        arrivalDatePicker.date = midnightToday
        updateDate()
        
        adultsCount.text = String(adultsCountInt)
        childrenCount.text = String(childrenCountInt)
    }
    
    // Метод, вызывающийся при отображении ячеек. То есть когда приходит запрос на высоту ячейки indexPath.row  в секции indexPath.section.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case arrivalDatePickerCellIndexPath:
            if isArrivalDatePickerShown {
                return 216
            } else {
                return 0
            }
        case departureDatePickerCellIndexPath:
            if isDepartureDatePickerShown {
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    // Метод, вызывающийся при нажатии на ячейку.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (arrivalDatePickerCellIndexPath.section, arrivalDatePickerCellIndexPath.row - 1):
            if isArrivalDatePickerShown {
                isArrivalDatePickerShown = false
            } else if isDepartureDatePickerShown {
                isDepartureDatePickerShown = false
                isArrivalDatePickerShown = true
            } else {
               isArrivalDatePickerShown = true
            }
        case (departureDatePickerCellIndexPath.section, departureDatePickerCellIndexPath.row - 1):
            if isDepartureDatePickerShown {
                isDepartureDatePickerShown = false
            } else if isArrivalDatePickerShown {
                isArrivalDatePickerShown = false
                isDepartureDatePickerShown = true
            } else {
                isDepartureDatePickerShown = true
            }
        default:
            isArrivalDatePickerShown = false
            isDepartureDatePickerShown = false
        }
        
        tableView.beginUpdates() // tableView.reloadData() не имеет смысла, т.к. нет источника данных.
        tableView.endUpdates()
    }
    
    func updateDate() {
        departureDatePicker.minimumDate = arrivalDatePicker.date.addingTimeInterval(60 * 60 * 24) // При изменении даты в arrivalDatePicker (как только установили дату, сработал @IBAction updateDate) вызывается этот метод, где меняется минимальная дата departureDatePicker относительно выбранной даты в arrivalDatePicker на одень день вперед. Затем идет отображение этих дат в lable'ы. При изменении даты в departureDatePicker, его минимальная дата остается той же, т.к. arrivalDatePicker не трогали, но зато обновляется поле departureDate.
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        arrivalDate.text = dateFormatter.string(from: arrivalDatePicker.date)
        departureDate.text = dateFormatter.string(from: departureDatePicker.date)
    }

}
