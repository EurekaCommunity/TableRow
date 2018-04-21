//
//  TableInlineRow.swift
//  TableRow
//
//  Created by Anton Kovtun on 17.03.18.
//  Copyright © 2018 Anton Kovtun. All rights reserved.
//

import Eureka
import UIKit

open class TableInlineCell<T: Equatable>: Cell<T>, CellType {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func setup() {
        super.setup()
        accessoryType = .none
        editingAccessoryType =  .none
    }
    
    override open func update() {
        super.update()
        selectionStyle = row.isDisabled ? .none : .default
    }
    
    override open func didSelect() {
        super.didSelect()
        row.deselect()
    }
}

open class _TableInlineRow<T> : Row<TableInlineCell<T>>, NoValueDisplayTextConformance where T: Equatable {
    
    open var options = [T]()
    
    public var noValueDisplayText: String?
    private var subcellConfigurator: (UITableViewCell, T, Int) -> Void = { _, _, _ in }
    
    public func setupInlineRow(_ inlineRow: TableRow<T>) {
        inlineRow.options = options
        inlineRow.displayValueFor = displayValueFor
        inlineRow.configureCell(subcellConfigurator)
        inlineRow.value = value
    }
    
    /// The block used to configure cells of underlying `SelectionListRow`
    @discardableResult
    open func configureSubcell(_ configurator: @escaping (UITableViewCell, T, Int) -> Void) -> Self {
        subcellConfigurator = configurator
        return self
    }
}

final public class TableInlineRow<T>: _TableInlineRow<T>, RowType, InlineRowType where T: Equatable {
    
    /// Sets underlying `SelectionListRow` textLabel color
    public var subcellTextColor = UIColor.gray
    /// Sets underlying `SelectionListRow` horizontal insets in it's superview
    public var subcellHorizontalInset: CGFloat = 16
    /// Sets whether row should collapse on option selection, defaults to true
    public var collapseOnInlineRowSelection = true
    
    required public init(tag: String?) {
        super.init(tag: tag)
        onExpandInlineRow { cell, row, _ in
            let color = cell.detailTextLabel?.textColor
            row.onCollapseInlineRow { cell, _, _ in
                cell.detailTextLabel?.textColor = color
            }
            cell.detailTextLabel?.textColor = cell.tintColor
        }
    }
    
    override public func customDidSelect() {
        super.customDidSelect()
        if !isDisabled {
            toggleInlineRow()
        }
    }
    
    override public func setupInlineRow(_ inlineRow: InlineRow) {
        super.setupInlineRow(inlineRow)
        inlineRow.onDidSelect { [weak self] _ in
            if self?.collapseOnInlineRowSelection ?? true {
                self?.toggleInlineRow()
            }
        }
        inlineRow.textColor = subcellTextColor
        inlineRow.horizontalContentInset = subcellHorizontalInset
    }
    
    /// This block gets called immediately and on `expanded/collapsed` state changes,
    /// setting first parameter `true` if `expanded`
    @discardableResult
    public func onToggleInlineRow(_ callback: @escaping (Bool, TableInlineCell<T>, TableInlineRow<T>, InlineRow) -> Void) -> TableInlineRow {
        callback(isExpanded, cell, self, inlineRow ?? InlineRow())
        onExpandInlineRow { callback(true, $0, $1, $2) }
        onCollapseInlineRow { callback(false, $0, $1, $2) }
        return self
    }
}
