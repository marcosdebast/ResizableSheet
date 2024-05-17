//
//  ContentView.swift
//  ResizableSheet
//
//  Created by Marcos Debastiani on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var openModal1: Bool = false
    @State var openModal2: Bool = false
    @State var openModal3: Bool = false
    @State var openModal4: Bool = false
    @State var openModal5: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("My section") {
                    Button {
                        openModal1.toggle()
                    } label: {
                        Text("Open sheet with width 500 and height 200")
                    }
                    Button {
                        openModal2.toggle()
                    } label: {
                        Text("Open sheet with width 500 and height 1000")
                    }
                    Button {
                        openModal3.toggle()
                    } label: {
                        Text("Open sheet with width 50 and height 50")
                    }
                    Button {
                        openModal4.toggle()
                    } label: {
                        Text("Open regular sheet")
                    }
                    Button {
                        openModal5.toggle()
                    } label: {
                        Text("Open fullScreen sheet")
                    }
                }
            }
            .navigationTitle("Resizable Sheet")
        }
        .resizableSheet(isPresented: $openModal1, width: 500, height: 200) {
            SheetView(navigationTitle: "Width 500 and Height 200", color: .red)
        }
        .resizableSheet(isPresented: $openModal2, width: 500, height: 1000) {
            SheetView(navigationTitle: "Width 500 and Height 1000", color: .green)
        }
        .modal(isPresented: $openModal3, type: .resizableSheet(width: 50, height: 50)) {
            SheetView(navigationTitle: "Width 50 and Height 50", color: .blue)
        }
        .modal(isPresented: $openModal4, type: .sheet) {
            SheetView(navigationTitle: "Regular sheet", color: .purple)
        }
        .modal(isPresented: $openModal5, type: .fullScreen) {
            SheetView(navigationTitle: "FullScreen sheet", color: .brown)
        }
    }
}

#Preview {
    ContentView()
}
