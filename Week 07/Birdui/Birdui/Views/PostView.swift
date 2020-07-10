//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//
import SwiftUI


struct PostView: View {
  
  @ObservedObject var postViewModel = PostViewModel()

  var body: some View {
    // Post cell
    List(postViewModel.posts.indices) { index in
      VStack(alignment: .leading) {
        // Post header: post icon, username and date
        HStack {
          Image("mascot_swift-badge")
            .resizable()
            .frame(width: 50, height: 50)
          
          VStack(alignment: .leading, spacing: 5) {
            Text("\(self.postViewModel.posts[index].userName)")
              .font(.headline)
            
            Text(self.postViewModel.posts[index].timestamp.toString())
              .font(.subheadline)
          }
        }
        
        // Post body test
        Text("\(self.postViewModel.posts[index].textBody!)")
          .font(.body)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        // Post image
        if self.postViewModel.posts[index].uiImage != nil {
          HStack {
            Spacer()
            
            Image(uiImage: self.postViewModel.posts[index].uiImage!)
              .resizable()
              .scaledToFit()
              .frame(maxHeight: 200, alignment: .center)
            
            Spacer()
          }
        }
      }
      .padding(.vertical, 7.5)
    }
  }
  
}


struct PostView_Previews: PreviewProvider {
  
  static var previews: some View {
    Group {
      PostView(postViewModel: PostViewModel())
      PostView(postViewModel: PostViewModel())
        .preferredColorScheme(.dark)
    }
  }
  
}
