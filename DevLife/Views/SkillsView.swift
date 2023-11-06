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
        VStack {
            if let skillsData = viewModel.skillsData {
                List {
                    SkillCategoryView(category: skillsData.Skills.Languages)
                    SkillCategoryView(category: skillsData.Skills.SoftSkills)
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchSkillsJson()
            }
        }
    }
}

struct SkillCategoryView: View {
    let category: SkillCategory

    var body: some View {
        Section(header: Text(category.description)) {
            ForEach(category.options) { option in
                Text(option.name)
            }
        }
    }
}


#Preview {
    SkillsView()
}
