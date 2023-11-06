//
//  SkillsView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct SkillsView: View {
    @StateObject private var viewModel = SkillsViewModel()
    @ObservedObject private var attributesViewModel = AttributesViewModel()

    var body: some View {
        NavigationView {
                   List {
                       if let skills = viewModel.skillsData?.Skills {
                           ForEach(skills) { category in
                               NavigationLink(destination: CategoryDetailView(category: category, attributesViewModel: attributesViewModel)) {
                                   Text(category.categoryName)
                               }
                           }
                       }
                   }
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchSkillsJson()
                    } catch DataFetchError.downloadError(let message) {
                        print("Download error: \(message)")
                    } catch DataFetchError.decodeError(let message) {
                        print("Decode error: \(message)")
                    } catch {
                        print("An unexpected error occurred: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}


#Preview {
    SkillsView()
}
