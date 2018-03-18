//
//  IntrinsicContentSizeTableView.swift
//  TableRow
//
//  Created by Anton Kovtun on 18.03.18.
//  Copyright © 2018 Anton Kovtun. All rights reserved.
//

import UIKit

final class IntrinsicSizeTableView: UITableView {
    var rowCount = 0
    
    override var intrinsicContentSize: CGSize {
        let headerHeight = tableHeaderView?.bounds.height ?? 0
        return CGSize(width: -1, height: headerHeight + CGFloat(rowCount) * rowHeight)
    }
}
