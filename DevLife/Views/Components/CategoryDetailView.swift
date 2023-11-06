//
//  CategoryDetailView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    var attributesViewModel: AttributesViewModel

    var body: some View {
        List {
            Text(category.description)
            ForEach(category.items) { item in
                Button(action: {
                    attributesViewModel.applySkillAttributes(item.attributes)
                }) {
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text(item.description).font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle(category.categoryName)
    }
}


