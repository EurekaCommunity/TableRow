//
//  ViewController.swift
//  Example
//
//  Created by Anton Kovtun on 18.03.18.
//  Copyright © 2018 Anton Kovtun. All rights reserved.
//

import Eureka
import TableRow
import UIKit

final class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForm()
    }
    
    private func setupForm() {
        form
            +++ sectionTableRow
            +++ sectionTableInlineRow
    }
    
    private var sectionTableRow: Eureka.Section {
        return Section("Table Row")
            <<< TableRow<String> { row in
                row.title = "Pick Option"
                row.options = (1...5).map { "Option \($0)" }
                row.horizontalContentInset = 32
            }
    }
    
    private var sectionTableInlineRow: Eureka.Section {
        return Section("Table Inline Row")
            <<< TableInlineRow<Int> { row in
                row.title = "Pick Option"
                row.options = Array(1...5)
                row.displayValueFor = { $0.flatMap { "Option \($0)" } }
                row.configureSubcell { cell, _, _ in  cell.tintColor = .orange }
            }
    }
}

