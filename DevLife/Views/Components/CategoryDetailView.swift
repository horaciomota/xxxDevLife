//
//  CategoryDetailView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct CategoryDetailView: View {
    var category: Category

    var body: some View {
        List {
            Text(category.description)
            ForEach(category.items) { item in
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text(item.description).font(.subheadline)
                }
            }
        }
        .navigationTitle(category.categoryName)
    }
}

