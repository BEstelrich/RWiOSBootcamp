//
//  NewPostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//
import SwiftUI

struct NewPostView: View {
  
  @Environment(\.presentationMode) var presentationMode
  var postViewModel: PostViewModel
  
  @State private var username: String = ""
  @State private var postText: String = ""
  @State private var showImagePicker = false
  @State private var image: UIImage?
  @State private var inputImage: UIImage?
  
  
  let imageSize: CGFloat = 200
  
  
  var body: some View {
    NavigationView {
      // Texfields section and image picker button
      Form {
        TextField("Username", text: $username)
        
        Button("Pick image") {
          self.showImagePicker = true
        }
        
        if image != nil {
          Image(uiImage: image!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSize, height: imageSize)
        }
        
        TextField("Post text", text: $postText)
      }
      // NavigationView: title, cancel and post buttons
      .navigationBarTitle(Text("New post"), displayMode: .inline)
      .navigationBarItems(leading:
        Button("Cancel") {
          self.presentationMode.wrappedValue.dismiss()
        }, trailing:
        Button("Post") {
          self.postViewModel.addPost(post: MediaPost(textBody: self.postText,
                                                     userName: self.username,
                                                     timestamp: Date(),
                                                     uiImage: self.image))
          self.presentationMode.wrappedValue.dismiss()
        }
        .disabled(username.isEmpty && postText.isEmpty)
      )
      
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
      ImagePicker(image: self.$inputImage)
    }
    
  }
  
  // Loads the image from the image chosen by the user in the image picker
  func loadImage() {
    guard let inputImage = inputImage else { return }
    image = inputImage
  }
  
}


struct NewPostView_Previews: PreviewProvider {
  
  static var previews: some View {
    Group {
      NewPostView(postViewModel: PostViewModel())
      NewPostView(postViewModel: PostViewModel())
        .preferredColorScheme(.dark)
    }
  }
  
}
