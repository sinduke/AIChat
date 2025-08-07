//
//  Color+EXT.swift
//  AIChat
//
//  Created by sinduke on 7/23/25.
//

import SwiftUI

extension Color {
    /// 使用 hex 字符串或整数创建颜色
    /// 示例：Color(hex: "#FF0000") 或 Color(hex: 0xFF0000)
    init(hex: String, alpha: Double = 1.0) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var hexNumber: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hexNumber)
        self.init(hex: hexNumber, alpha: alpha)
    }
    
    init(hex: UInt64, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255
        let green = Double((hex & 0x00FF00) >> 8) / 255
        let blue = Double(hex & 0x0000FF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    
    /// 将 Color 转为 hex 字符串（如 "#FF0000"）
    /// 注意：仅对从 UIColor 创建的 Color 有效，否则返回 nil
    func toHex() -> String? {
#if canImport(UIKit)
        var uiColor: UIColor?
        if #available(iOS 14.0, *) {
            uiColor = UIColor(self)
        }
        guard let components = uiColor?.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let red = Int((components[0] * 255).rounded())
        let green = Int((components[1] * 255).rounded())
        let blue = Int((components[2] * 255).rounded())
        
        return String(format: "#%02X%02X%02X", red, green, blue)
#else
        return nil
#endif
    }
    
    var asHex: String {
        toHex() ?? Constants.accentColorHex
    }
    
}
