<!-- Header -->
<img src="../Assets/W07_AppIcon.png" width="60" align="right"/>
<h1>Week 07. SwiftUI</h1>

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.5+-lightgrey.svg?longCache=true&?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![](https://img.shields.io/badge/-@BEstelrichS-00ACEE.svg?style=social&logo=twitter)](https://twitter.com/BEstelrichS)


<!-- Body -->
## Frameworks
- SwiftUI


## Description
This project has been conceived as a **team** assignment and completed exclusively in **SwiftUI**. The main goal is to build a simple list that **displays some predefined posts** and allows the user to **make a new post with and without attached image**.

Data has been passed through the different views by conforming the model to the `ObservableObject` protocol and defining the model instance in the view as `ObservedObject`. **MVVM was the chosen pattern** to build the app. Finally the **Image picker** implementation has taken place by creating a `Coordinator` class that conformed to `UIImagePickerControllerDelegate` and passed the selected image from its delegate.


## Preview
Those are the most relevant screenshots on the app.

<p align="left">
	<img src="../Assets/W07_Screenshot1.png" height="500"/>
	<img src="../Assets/W07_Screenshot2.png" height="500"/>
	<img src="../Assets/W07_Screenshot3.png" height="500"/>
</p>


<!-- Footer -->