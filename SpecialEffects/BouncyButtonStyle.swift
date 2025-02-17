//
//  BouncyButtonStyle.swift
//  To-Do
//
//  Created by Claire Alverson on 11/26/24.
//

import SwiftUI

struct BouncyButtonStyle: ButtonStyle {
    @State private var isPressed: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0) // inflate when pressed
            .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.0), value: configuration.isPressed)
    }
}
