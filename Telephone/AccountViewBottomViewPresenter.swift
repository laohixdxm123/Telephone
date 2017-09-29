//
//  AccountViewBottomViewPresenter.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2017 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import Foundation

final class AccountViewBottomViewPresenter: NSObject {
    private let constraint: NSLayoutConstraint
    private let height: CGFloat
    fileprivate let button: NSButton
    fileprivate let controller: CallHistoryViewController

    init(constraint: NSLayoutConstraint, height: CGFloat, button: NSButton, controller: CallHistoryViewController) {
        self.constraint = constraint
        self.height = height
        self.button = button
        self.controller = controller
    }

    func hideWithoutAnimation() {
        constraint.constant = 0
    }

    fileprivate func show() {
        constraint.animator().constant = height
    }

    fileprivate func hide() {
        constraint.animator().constant = 0
    }
}

extension AccountViewBottomViewPresenter: RecordCountingPurchaseCheckUseCaseOutput {
    func didCheckPurchase() {
        hide()
    }

    func didFailCheckingPurchase(recordCount count: Int) {
        if count > controller.recordCount {
            button.title = makeButtionTitleWithCounts(total: count, current: controller.recordCount)
            show()
        } else {
            hide()
        }
    }
}

private func makeButtionTitleWithCounts(total: Int, current: Int) -> String {
    return String(
        format: NSLocalizedString("Show %d more…", comment: "Show more call history records button."), total - current
    )
}
