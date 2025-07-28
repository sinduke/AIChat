//
//  Binding+EXT.swift
//  AIChat
//
//  Created by sinduke on 7/28/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(isNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
