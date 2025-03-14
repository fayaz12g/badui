//
//  DeleteCommentLevel.swift
//  BadUI
//
//  Created by Fayaz Shaikh on 3/14/25.
//

import SwiftUI

struct DeleteCommentLevel: View {
    let onComplete: (Int) -> Void
    @State private var comments = ["wow so cute!"]
    @State private var newComment = ""
    @State private var likes = 0
    @State private var isLiked = false
    @State private var showTerms = false
    @State private var timeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Fake Social Media Post")
                .font(.title)
                .padding()
            
            Text("Time: \(timeElapsed)s")
                .font(.headline)
            
            Image("cat")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding()
            
            HStack {
                Button(isLiked ? "Unlike" : "Like") {
                    isLiked.toggle()
                    likes += isLiked ? 1 : -1
                }
                .foregroundColor(isLiked ? .red : .primary)
                
                Text("\(likes) \(likes == 1 ? "like" : "likes")")
            }
            .padding()
            
            Text("Delete your comment")
                .font(.headline)
                .padding()
            
            List {
                ForEach(comments, id: \.self) { comment in
                    Text(comment)
                }
            }
            .frame(height: 200)
            
            HStack {
                TextField("Write a comment...", text: $newComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Post") {
                    handleComment()
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding()
            
            Button("Terms of Service") {
                showTerms = true
            }
            .sheet(isPresented: $showTerms) {
                TermsView(showTerms: $showTerms)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            timeElapsed += 1
        }
    }
    
    private func handleComment() {
        guard !newComment.isEmpty else { return }
        
        let duplicates = comments.filter { $0 == newComment }
        if !duplicates.isEmpty {
            comments.removeAll { $0 == newComment }
            if comments.isEmpty {
                timer.upstream.connect().cancel()
                onComplete(timeElapsed)
            }
        } else {
            comments.append(newComment)
        }
        newComment = ""
    }
}
