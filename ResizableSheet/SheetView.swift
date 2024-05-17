//
//  SheetView.swift
//  ResizableSheet
//
//  Created by Marcos Debastiani on 17/05/24.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    let navigationTitle: String
    let color: Color
    
    var body: some View {
        NavigationStack {
            color
                .navigationTitle(navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
}
