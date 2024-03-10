//
//  Expandable button.swift
//  Week06
//
//  Created by Yupu Chan on 7/3/2024.
//

import SwiftUI

struct ExpandableButton: Identifiable{
    let id = UUID()
    let label: Image
    var action: (() -> Void)? = nil

}

struct ExpandableButtonPanel: View {
    
    let primaryItem: ExpandableButton
    let secondaryItems: [ExpandableButton]
    
    @State private var isExpanded = false
    
    private let noop: () -> Void = {}
    private let size: CGFloat = 45
    private var cornerRadius: CGFloat {
        get {size/2}
    }
    
    private let shadowColor = Color.black.opacity(0.4)
    private let shadowPosition: (x: CGFloat, y: CGFloat) = (x: 2, y: 2)
    private let shadowRadius: CGFloat = 3
    

    var body: some View {
        VStack {
            Button (action: {
                withAnimation {
                    self.isExpanded.toggle()
                }
                self.primaryItem.action?()
            }) {
                withAnimation {
                    self.isExpanded ? Image(systemName: "house") : primaryItem.label
                }
            }
            .frame(width: size, height: size)
            
            if isExpanded {
                ForEach(secondaryItems) { item in
                    Button(action: {
                        withAnimation {
                            self.isExpanded.toggle()
                        }
                        item.action?()
                    }
                    
                    ) {
                        item.label
                    }
                    .frame(width: self.size, height: self.size)
                }
            }
        }
        .background(Color(#colorLiteral(red: 0.4858539104, green: 0.7752999663, blue: 0.9617900252, alpha: 1)))
        .cornerRadius(cornerRadius)
    }
    

}

