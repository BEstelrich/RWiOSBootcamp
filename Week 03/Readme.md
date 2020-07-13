<!-- Header -->
<img src="../Assets/W03_AppIcon.png" width="60" align="right"/>
<h1>Week 03. Swift functions and types</h1>

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.5+-lightgrey.svg?longCache=true&?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![](https://img.shields.io/badge/@BEstelrichS-1A94E0.svg?logoColor=white&logo=twitter)](https://twitter.com/BEstelrichS)


<!-- Body -->
## Frameworks/External dependencies
- Foundation
- UIKit


## Description
This short project is about creating an app called Cryptly that **displays some cryptocurrencies** prices generated from an embedded JSON file.

Starting from a Singleton object that generates a simulated cryptocurrency data, the model object it's created to accommodate this data. To set the view up, a data parsing has been done on the model instance by using **Higher Order Functions** in order to filter the correspondent information on each view.

On the order hand, **theme support** is implemented by creating a protocol that defines the theme requirements. An object that conforms to this protocol is being passed to the `Theme Manager` Singleton triggering an observer from the view-controller that takes care of the theme application itself.

Finally, an additional protocol called `Roundable` is set to define any view with **rounded corners**. Also default rounded method is provided by **overloading a protocol required method**.


## Preview
Those are the most relevant screenshots on the app.

<p align="left">
	<img src="../Assets/W03_Screenshot1.png" height="500"/>
	<img src="../Assets/W03_Screenshot2.png" width="500"/>
</p>


<!-- Footer -->