//
//  SkillsView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct SkillsView: View {
    @StateObject private var viewModel = SkillsViewModel()

    var body: some View {
        List {
            if let skills = viewModel.skillsData?.Skills {
                ForEach(skills) { category in
                    Section(header: Text(category.categoryName)) {
                        Text(category.description)
                        ForEach(category.items) { item in
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.description).font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchSkillsJson()
                } catch {
                    print("Error fetching skills: \(error)")
                }
            }
        }
    }
}



#Preview {
    SkillsView()
}
