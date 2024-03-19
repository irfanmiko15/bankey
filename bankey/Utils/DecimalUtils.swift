//
//  DecimalUtils.swift
//  bankey
//
//  Created by Irfan Dary on 19/03/24.
//

import Foundation

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
