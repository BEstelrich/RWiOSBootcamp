//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//
import SwiftUI


struct PostView: View {
  
  @ObservedObject var postViewModel: PostViewModel

  var body: some View {
    // Post cell
    List(postViewModel.posts, id: \.self) { post in
      VStack(alignment: .leading) {
        // Post header: post icon, username and date
        HStack {
          Image("mascot_swift-badge")
            .resizable()
            .frame(width: 50, height: 50)
          
          VStack(alignment: .leading, spacing: 5) {
            Text("\(post.userName)")
              .font(.headline)
            
            Text(post.timestamp.toString())
              .font(.subheadline)
          }
        }
        
        // Post body test
        Text("\(post.textBody!)")
          .font(.body)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        // Post image
        if post.uiImage != nil {
          HStack {
            Spacer()
            
            Image(uiImage: post.uiImage!)
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
