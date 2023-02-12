//
//  SearchSubredditsView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 04/02/23.
//

import Foundation
import SwiftUI
import Combine

struct SearchSubredditsView: View {
    
    @ObservedObject var vm: SearchSubredditsViewModel
    @StateObject var term = DebounceObject()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.subredditsList, id: \.id) { sub in
                        SubredditTile(subreddit: sub)
                            .onTapGesture {
                                vm.send(action: .openSub(sub))
                            }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("Search", text: $term.text)
                    .font(.body)
                    .frame(height: 55)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing], 5)
                    .cornerRadius(16)
                    .scaledToFill()
                    .onChange(of: term.debouncedText) { text in
                        vm.send(action: .load(text.sanitized))
                    }
            }
            ToolbarItem(placement: .destructiveAction) {
                Button("Cancel") {
                    vm.send(action: .cancel)
                }
            }
        }.padding()
    }
}

public extension String {
    var sanitized: String {
        return self
            .replacingOccurrences(of: "[^a-zA-Z0-9]", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .replacingOccurrences(of: " ", with: "")
    }
}

public final class DebounceObject: ObservableObject {
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    private var bag = Set<AnyCancellable>()

    public init(dueTime: TimeInterval = 0.5) {
        $text
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.debouncedText = value
            })
            .store(in: &bag)
    }
}
