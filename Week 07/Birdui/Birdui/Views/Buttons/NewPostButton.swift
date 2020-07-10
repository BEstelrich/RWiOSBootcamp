// 2020.07.10 | Birdui - NewPostButton.swift | Copyright © 2020 Razeware. All rights reserved.
import SwiftUI


struct NewPostButton: View {
  
  @State private var newPostViewIsPresented = false
  var postViewModel: PostViewModel
  
  var body: some View {
    Button("New post") { self.newPostViewIsPresented = true }
    .font(.subheadline)
    .padding(.horizontal, 10)
    .padding(.vertical, 5)
    .foregroundColor(Color.white)
    .background(Color.init(red:0.996, green:0.365, blue:0.184))
    .clipShape(Capsule())
    .sheet(isPresented: self.$newPostViewIsPresented) {
      NewPostView(postViewModel: self.postViewModel)
    }
  }
  
}
