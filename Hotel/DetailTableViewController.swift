//
//  DetailTableViewController.swift
//  Hotel
//
//  Created by Timur Saidov on 22/10/2018.
//  Copyright © 2018 Timur Saidov. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var roomTypePicker: UIPickerView!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var roomPriceLabel: UILabel!
    
    var roomType: [RoomType] = [
        RoomType(id: 0, name: "Single", shortName: "SNGL", price: 100),
        RoomType(id: 1, name: "Double", shortName: "DBL", price: 200),
        RoomType(id: 2, name: "Triple", shortName: "TRPL", price: 300),
        RoomType(id: 3, name: "Quadriple", shortName: "QDPL", price: 400),
        RoomType(id: 4, name: "Double + Extra bed", shortName: "EXB", price: 265),
        RoomType(id: 5, name: "Single + Infant", shortName: "SNGL+INF", price: 125),
        RoomType(id: 6, name: "Single + Child", shortName: "SNGL+CHL", price: 145),
        RoomType(id: 7, name: "Double + Infant", shortName: "DBL+INF", price: 225),
        RoomType(id: 8, name: "Double + Child", shortName: "DBL+CHL", price: 245),
    ]
    
    var isRoomTypePickerShown: Bool = false
    var roomTypeToFirstVC: RoomType?
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        guard let _ = roomTypeToFirstVC else {
            let ac = UIAlertController(title: "Choise room type please", message: "You should choise any room type to make registration", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            ac.addAction(ok)
            self.present(ac, animated: true, completion: nil)
            
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        roomTypePicker.dataSource = self
        roomTypePicker.delegate = self
        
        guard let roomType = roomTypeToFirstVC else { return }
        print(roomType)
        roomTypeLabel.text = roomType.name
        roomPriceLabel.text = "$\(roomType.price) / 1 day"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case IndexPath(row: 1, section: 0):
            if isRoomTypePickerShown {
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            if isRoomTypePickerShown {
                isRoomTypePickerShown = false
            } else {
                isRoomTypePickerShown = true
            }
        default:
            isRoomTypePickerShown = false
        }
        tableView.reloadData()
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roomType.count
    }

    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(roomType[row].name) - $\(roomType[row].price)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRow = roomTypePicker.selectedRow(inComponent: 0)
        let selectedRoomType = roomType[selectedRow]
        roomTypeToFirstVC = selectedRoomType
        
        roomTypeLabel.text = selectedRoomType.name
        roomPriceLabel.text = "$\(selectedRoomType.price) / 1 day"
    }
}
