//
//  UserDetailRepositoryListView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/13.
//

import SwiftUI

extension UserDetailScreenView {
    struct UserDetailRepositoryListView<State: UserDetailRepositoryListStateProtocol>: View {
        @ObservedObject var state: State
        
        var body: some View {
            VStack {
                Text("RepositoryList")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4.0)
                    .padding(.leading, 8.0)
                    .background(Color.gray.opacity(0.5))
                
                LazyVGrid(columns: [.init()], alignment: .leading, spacing: 8.0) {
                    ForEach(state.items, id: \.id) { item in
                        UserDetailRepositoryDetailView(state: item)
                            .padding(.horizontal, 8.0)
                    }
                }
            }
        }
    }
}

private struct UserDetailRepositoryDetailView<State: UserDetailRepositoryDetailStateProtocol>: View {
    @ObservedObject var state: State
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(state.name)
                .lineLimit(1)
            
            Text(state.fullName)
                .lineLimit(1)
            
            Text(state.description ?? "")
                .lineLimit(2)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    WebView(loadUrl: state.url)
                } label: {
                    Text("詳細を見る")
                }
            }
        }
        .padding(.all, 8.0)
        .border(.gray, width: 2.0)
    }
}
