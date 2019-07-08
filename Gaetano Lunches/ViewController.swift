//
//  ViewController.swift
//  Gaetano Lunches
//
//  Created by Денис Обухов on 07/07/2019.
//  Copyright © 2019 Oggetto. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableHeader: NSTableHeaderView!
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var textLabel: NSTextFieldCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.stringValue = NSLocalizedString("TODAY_IS", comment: "Today is") + getCurrentDate()
        tableView.reloadData();
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todayMenu.count
    }
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) -> String? {
        return todayMenu[row];
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
    {
        return todayMenu[row];
    }
    
    func getCurrentDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, yyyy"
        return dateFormatter.string(from: now)
    }


}

