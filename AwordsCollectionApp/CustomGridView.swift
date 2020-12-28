//
//  CustomGridView.swift
//  AwordsCollectionApp
//
//  Created by Alexey Efimov on 27.12.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import SwiftUI

struct CustomGridView<Content, T>: View where Content: View {
    
    var columns: Int
    let items: [T]
    let content: (_ calculatedWidth: CGFloat,_ type: T) -> Content
    
    var rows: Int {
        (items.count - 1) / columns
    }
    
    init(columns: Int, items:[ T], @ViewBuilder content: @escaping(_ calculatedWidth: CGFloat,_ type: T) -> Content) {
        self.columns = columns
        self.items = items
        self.content = content
    }
    
    private func indexFor(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < items.count ? index : nil
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ForEach(0...rows, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<columns) { columnIndex in
                                if let index = indexFor(row: rowIndex, column: columnIndex) {
                                    self.content(geometry.size.width / CGFloat(self.columns), items[index])
                                } else {
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CustomGridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomGridView (columns: 3, items: [11, 3, 7, 17, 5, 2, 1], content: { gridWidth,item  in
            Text("\(item)")
                .padding()
                .frame(width: gridWidth, height: gridWidth)
        })
    }
}
