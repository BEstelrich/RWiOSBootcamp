//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//
import SwiftUI


struct PostListView: View {
  
  @Environment(\.presentationMode) var presentationMode
  var postViewModel = PostViewModel()
  
  
  var body: some View {
    NavigationView {
      Section {
        // Posts list
        PostView(postViewModel: postViewModel)
      }
      // Navigation view
      .navigationBarTitle(Text("Home"), displayMode: .automatic)
      .navigationBarItems(leading: NavigationBarImage(),
                          trailing: NewPostButton(postViewModel: postViewModel))
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
}


struct PostListView_Previews: PreviewProvider {
  
  static var previews: some View {
    Group {
      PostListView(postViewModel: PostViewModel())
      PostListView(postViewModel: PostViewModel())
        .preferredColorScheme(.dark)
    }
  }
  
}
